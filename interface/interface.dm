//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki(query as text)
	set name = "wiki"
	set desc = "Введите название интересующей вас темы.  Это откроет вики-страницу в веб-браузере. Чтобы перейти на главную страницу, оставте поле пустым."
	set hidden = TRUE
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl)
		if(query)
			var/output = wikiurl + "/index.php?title=Special%3ASearch&profile=default&search=" + query
			src << link(output)
		else if (query != null)
			src << link(wikiurl)
	else
		to_chat(src, span_danger("URL-адрес wiki не задан в конфигурации сервера."))
	return

/client/verb/forum()
	set name = "forum"
	set desc = "Посетить форум."
	set hidden = TRUE
	var/forumurl = CONFIG_GET(string/forumurl)
	if(forumurl)
		if(tgui_alert(src, "В вашем браузере откроется форум. Вы уверены?",, list("Да","Нет"))!="Да")
			return
		src << link(forumurl)
	else
		to_chat(src, span_danger("URL-адрес форума не задан в конфигурации сервера."))
	return

/client/verb/rules()
	set name = "rules"
	set desc = "Показать правила сервера."
	set hidden = TRUE
	var/rulesurl = CONFIG_GET(string/rulesurl)
	if(rulesurl)
//		if(tgui_alert(src, "В вашем браузере откроются правила.. Вы уверены?",, list("Да","Нет"))!="Да")
		if(tgui_alert(src, "На сервере есть правила которых стоит придерживаться. \
							Прочесть и ознакомиться с правилами можно в самой игре распечатав их на принтере.","Правила сервера", list("OK"))!="OK")
			return
//		src << link(rulesurl)
	else
		to_chat(src, span_danger("URL-адрес правил не задан в конфигурации сервера."))
	return

/client/verb/github()
	set name = "github"
	set desc = "Посетить Github"
	set hidden = TRUE
	var/githuburl = CONFIG_GET(string/githuburl)
	if(githuburl)
		if(tgui_alert(src, "В браузере откроется репозиторий Github. Вы уверены?",, list("Да","Нет"))!="Да")
			return
		src << link(githuburl)
	else
		to_chat(src, span_danger("URL-адрес Github не задан в конфигурации сервера."))
	return

/client/verb/reportissue()
	set name = "report-issue"
	set desc = "Сообщить об ошибке"
	set hidden = TRUE
	var/githuburl = CONFIG_GET(string/githuburl)
	if(githuburl)
		var/message = "В браузере откроется создание отчета о проблеме на Github. Вы уверены?"
		if(GLOB.revdata.testmerge.len)
			message += "<br>The following experimental changes are active and are probably the cause of any new or sudden issues you may experience. If possible, please try to find a specific thread for your issue instead of posting to the general issue tracker:<br>"
			message += GLOB.revdata.GetTestMergeInfo(FALSE)
		// We still use tgalert here because some people were concerned that if someone wanted to report that tgui wasn't working
		// then the report issue button being tgui-based would be problematic.
		if(tgalert(src, message, "Отправить отчёт","Да","Нет")!="Да")
			return

		// Keep a static version of the template to avoid reading file
		var/static/issue_template = file2text(".github/ISSUE_TEMPLATE/bug_report.md")

		// Get a local copy of the template for modification
		var/local_template = issue_template

		// Remove comment header
		var/content_start = findtext(local_template, "<")
		if(content_start)
			local_template = copytext(local_template, content_start)

		// Insert round
		if(GLOB.round_id)
			local_template = replacetext(local_template, "## Round ID:\n", "## Round ID:\n[GLOB.round_id]")

		// Insert testmerges
		if(GLOB.revdata.testmerge.len)
			var/list/all_tms = list()
			for(var/entry in GLOB.revdata.testmerge)
				var/datum/tgs_revision_information/test_merge/tm = entry
				all_tms += "- \[[tm.title]\]([githuburl]/pull/[tm.number])"
			var/all_tms_joined = all_tms.Join("\n") // for some reason this can't go in the []
			local_template = replacetext(local_template, "## Testmerges:\n", "## Testmerges:\n[all_tms_joined]")

		var/url_params = "Reporting client version: [byond_version].[byond_build]\n\n[local_template]"
		DIRECT_OUTPUT(src, link("[githuburl]/issues/new?body=[url_encode(url_params)]"))
	else
		to_chat(src, span_danger("The Github URL is not set in the server configuration."))
	return

/client/verb/changelog()
	set name = "Changelog"
	set category = "OOC"
	if(!GLOB.changelog_tgui)
		GLOB.changelog_tgui = new /datum/changelog()

	GLOB.changelog_tgui.ui_interact(mob)
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")

/client/verb/hotkeys_help()
	set name = "Hotkeys Help"
	set category = "OOC"

	if(!GLOB.hotkeys_tgui)
		GLOB.hotkeys_tgui = new /datum/hotkeys_help()

	GLOB.hotkeys_tgui.ui_interact(mob)
