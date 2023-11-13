/datum/computer_file/program/ntnetdownload
	filename = "ntsoftwarehub"
	filedesc = "NT Хаб софта"
	program_icon_state = "generic"
	extended_desc = "Эта программа позволяет загружать софт из официальных репозиториев NT"
	undeletable = TRUE
	size = 4
	requires_ntnet = TRUE
	available_on_ntnet = FALSE
	tgui_id = "NtosNetDownloader"
	program_icon = "download"

	var/datum/computer_file/program/downloaded_file
	var/hacked_download = FALSE
	var/download_completion = FALSE //GQ of downloaded data.
	var/download_netspeed = 0
	var/downloaderror = ""

	var/static/list/show_categories = list(
		PROGRAM_CATEGORY_CREW,
		PROGRAM_CATEGORY_ENGI,
		PROGRAM_CATEGORY_SCI,
		PROGRAM_CATEGORY_SUPL,
		PROGRAM_CATEGORY_MISC,
	)

/datum/computer_file/program/ntnetdownload/kill_program(mob/user)
	. = ..()
	ui_header = null

/datum/computer_file/program/ntnetdownload/proc/begin_file_download(filename)
	if(downloaded_file)
		return FALSE

	var/datum/computer_file/program/PRG = SSmodular_computers.find_ntnet_file_by_name(filename)

	if(!PRG || !istype(PRG))
		return FALSE

	// Attempting to download antag only program, but without having emagged/syndicate computer. No.
	if(PRG.available_on_syndinet && !(computer.obj_flags & EMAGGED))
		return FALSE

	if(!computer || !computer.can_store_file(PRG))
		return FALSE

	ui_header = "downloader_running.gif"

	if(PRG in SSmodular_computers.available_station_software)
		generate_network_log("Началась загрузка файла [PRG.filename].[PRG.filetype] из репозитория NT.")
		hacked_download = FALSE
	else if(PRG in SSmodular_computers.available_antag_software)
		generate_network_log("Началась загрузка файла **ЗАШИФРОВАНО**.[PRG.filetype] с неопределенного сервера.")
		hacked_download = TRUE
	else
		generate_network_log("Началась загрузка файла [PRG.filename].[PRG.filetype] с неопределенного сервера.")
		hacked_download = FALSE

	downloaded_file = PRG.clone()

/datum/computer_file/program/ntnetdownload/proc/abort_file_download()
	if(!downloaded_file)
		return
	generate_network_log("Прервано скачивание файла [hacked_download ? "**ЗАШИФРОВАНО**" : "[downloaded_file.filename].[downloaded_file.filetype]"].")
	downloaded_file = null
	download_completion = FALSE
	ui_header = null

/datum/computer_file/program/ntnetdownload/proc/complete_file_download()
	if(!downloaded_file)
		return
	generate_network_log("Завершена загрузка файла [hacked_download ? "**ЗАШИФРОВАНО**" : "[downloaded_file.filename].[downloaded_file.filetype]"].")
	if(!computer || !computer.store_file(downloaded_file))
		// The download failed
		downloaderror = "I/O ОШИБКА - Невозможно сохранить файл. Проверьте, достаточно ли свободного места на жестком диске и правильно ли подключен жесткий диск. Если проблема не исчезла, обратитесь за помощью к системному администратору."
	downloaded_file = null
	download_completion = FALSE
	ui_header = "downloader_finished.gif"

/datum/computer_file/program/ntnetdownload/process_tick(seconds_per_tick)
	if(!downloaded_file)
		return
	if(download_completion >= downloaded_file.size)
		complete_file_download()
	// Download speed according to connectivity state. NTNet server is assumed to be on unlimited speed so we're limited by our local connectivity
	download_netspeed = 0
	// Speed defines are found in misc.dm
	switch(ntnet_status)
		if(NTNET_LOW_SIGNAL)
			download_netspeed = NTNETSPEED_LOWSIGNAL
		if(NTNET_GOOD_SIGNAL)
			download_netspeed = NTNETSPEED_HIGHSIGNAL
		if(NTNET_ETHERNET_SIGNAL)
			download_netspeed = NTNETSPEED_ETHERNET
	download_completion += download_netspeed

/datum/computer_file/program/ntnetdownload/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	switch(action)
		if("PRG_downloadfile")
			if(!downloaded_file)
				begin_file_download(params["filename"])
			return TRUE
		if("PRG_reseterror")
			if(downloaderror)
				download_completion = FALSE
				download_netspeed = FALSE
				downloaded_file = null
				downloaderror = ""
			return TRUE
	return FALSE

/datum/computer_file/program/ntnetdownload/ui_data(mob/user)
	var/list/data = list()
	var/list/access = computer.GetAccess()

	data["downloading"] = !!downloaded_file
	data["error"] = downloaderror || FALSE

	// Download running. Wait please..
	if(downloaded_file)
		data["downloadname"] = downloaded_file.filename
		data["downloaddesc"] = downloaded_file.filedesc
		data["downloadsize"] = downloaded_file.size
		data["downloadspeed"] = download_netspeed
		data["downloadcompletion"] = round(download_completion, 0.1)

	data["disk_size"] = computer.max_capacity
	data["disk_used"] = computer.used_capacity
	data["emagged"] = (computer.obj_flags & EMAGGED)

	var/list/repo = SSmodular_computers.available_antag_software | SSmodular_computers.available_station_software
	var/list/program_categories = list()

	for(var/datum/computer_file/program/programs as anything in repo)
		if(!(programs.category in program_categories))
			program_categories.Add(programs.category)
		data["programs"] += list(list(
			"icon" = programs.program_icon,
			"filename" = programs.filename,
			"filedesc" = programs.filedesc,
			"fileinfo" = programs.extended_desc,
			"category" = programs.category,
			"installed" = !!computer.find_file_by_name(programs.filename),
			"compatible" = check_compatibility(programs),
			"size" = programs.size,
			"access" = programs.can_run(user, downloading = TRUE, access = access),
			"verifiedsource" = programs.available_on_ntnet,
		))

	data["categories"] = show_categories & program_categories

	return data

/datum/computer_file/program/ntnetdownload/proc/check_compatibility(datum/computer_file/program/P)
	var/hardflag = computer.hardware_flag

	if(P?.is_supported_by_hardware(hardware_flag = hardflag, loud = FALSE))
		return TRUE
	return FALSE

/datum/computer_file/program/ntnetdownload/kill_program(mob/user)
	abort_file_download()
	return ..()
