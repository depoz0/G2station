#define JOB_AVAILABLE 0
#define JOB_UNAVAILABLE_GENERIC 1
#define JOB_UNAVAILABLE_BANNED 2
#define JOB_UNAVAILABLE_PLAYTIME 3
#define JOB_UNAVAILABLE_ACCOUNTAGE 4
#define JOB_UNAVAILABLE_SLOTFULL 5
/// Job unavailable due to incompatibility with an antag role.
#define JOB_UNAVAILABLE_ANTAG_INCOMPAT 6
/// Checks for character age.
#define JOB_UNAVAILABLE_AGE 7

/// Used when the `get_job_unavailable_error_message` proc can't make sense of a given code.
#define GENERIC_JOB_UNAVAILABLE_ERROR "Error: Unknown job availability."

#define DEFAULT_RELIGION "Christianity"
#define DEFAULT_DEITY "Space Jesus"
#define DEFAULT_BIBLE "Default Bible Name"
#define DEFAULT_BIBLE_REPLACE(religion) "The Holy Book of [religion]"

#define JOB_DISPLAY_ORDER_DEFAULT 0

// Keys for jobconfig.toml
#define JOB_CONFIG_PLAYTIME_REQUIREMENTS "Playtime Requirements"
#define JOB_CONFIG_REQUIRED_ACCOUNT_AGE "Required Account Age"
#define JOB_CONFIG_REQUIRED_CHARACTER_AGE "Required Character Age"
#define JOB_CONFIG_SPAWN_POSITIONS "Spawn Positions"
#define JOB_CONFIG_TOTAL_POSITIONS "Total Positions"

/**
 * =======================
 * WARNING WARNING WARNING
 * WARNING WARNING WARNING
 * WARNING WARNING WARNING
 * =======================
 * These names are used as keys in many locations in the database
 * you cannot change them trivially without breaking job bans and
 * role time tracking, if you do this and get it wrong you will die
 * and it will hurt the entire time
 */

//No department
#define JOB_ASSISTANT "Ассистент"
#define JOB_PRISONER "Заключенный"
//Command
#define JOB_CAPTAIN "Капитан"
#define JOB_HEAD_OF_PERSONNEL "Глава персонала"
#define JOB_HEAD_OF_SECURITY "Глава службы безопасности"
#define JOB_RESEARCH_DIRECTOR "Директор исследований"
#define JOB_CHIEF_ENGINEER "Главный инженер"
#define JOB_CHIEF_MEDICAL_OFFICER "Главный врач"
//Silicon
#define JOB_AI "AI"
#define JOB_CYBORG "Cyborg"
#define JOB_PERSONAL_AI "Personal AI"
//Security
#define JOB_WARDEN "Надзиратель"
#define JOB_DETECTIVE "Детектив"
#define JOB_SECURITY_OFFICER "Офицер службы безопасности"
#define JOB_SECURITY_OFFICER_MEDICAL "Офицер службы безопасности (Медицина)"
#define JOB_SECURITY_OFFICER_ENGINEERING "Офицер службы безопасности (Инженерия)"
#define JOB_SECURITY_OFFICER_SCIENCE "Офицер службы безопасности (Наука)"
#define JOB_SECURITY_OFFICER_SUPPLY "Офицер службы безопасности (Грузы)"
//Engineering
#define JOB_STATION_ENGINEER "Станционный инженер"
#define JOB_ATMOSPHERIC_TECHNICIAN "Атмосферный техник"
//Medical
#define JOB_CORONER "Патологоанат"
#define JOB_MEDICAL_DOCTOR "Врач"
#define JOB_PARAMEDIC "Парамедик"
#define JOB_CHEMIST "Химик"
#define JOB_VIROLOGIST "Вирусолог"
//Science
#define JOB_SCIENTIST "Учёный"
#define JOB_ROBOTICIST "Робототехник"
#define JOB_GENETICIST "Генетик"
//Supply
#define JOB_QUARTERMASTER "Квартирмейстер"
#define JOB_CARGO_TECHNICIAN "Грузчик"
#define JOB_SHAFT_MINER "Шахтёр"
#define JOB_BITRUNNER "Bitrunner"
//Service
#define JOB_BARTENDER "Бармен"
#define JOB_BOTANIST "Ботаник"
#define JOB_COOK "Повар"
#define JOB_JANITOR "Уборщик"
#define JOB_CLOWN "Клоун"
#define JOB_MIME "Мим"
#define JOB_CURATOR "Библиотекарь"
#define JOB_LAWYER "Адвокат"
#define JOB_CHAPLAIN "Священник"
#define JOB_PSYCHOLOGIST "Психолог"
//ERTs
#define JOB_ERT_DEATHSQUAD "Death Commando"
#define JOB_ERT_COMMANDER "Emergency Response Team Commander"
#define JOB_ERT_OFFICER "Security Response Officer"
#define JOB_ERT_ENGINEER "Engineering Response Officer"
#define JOB_ERT_MEDICAL_DOCTOR "Medical Response Officer"
#define JOB_ERT_CHAPLAIN "Religious Response Officer"
#define JOB_ERT_JANITOR "Janitorial Response Officer"
#define JOB_ERT_CLOWN "Entertainment Response Officer"
//CentCom
#define JOB_CENTCOM "Central Command"
#define JOB_CENTCOM_OFFICIAL "CentCom Official"
#define JOB_CENTCOM_ADMIRAL "Admiral"
#define JOB_CENTCOM_COMMANDER "CentCom Commander"
#define JOB_CENTCOM_VIP "VIP Guest"
#define JOB_CENTCOM_BARTENDER "CentCom Bartender"
#define JOB_CENTCOM_CUSTODIAN "Custodian"
#define JOB_CENTCOM_THUNDERDOME_OVERSEER "Thunderdome Overseer"
#define JOB_CENTCOM_MEDICAL_DOCTOR "Medical Officer"
#define JOB_CENTCOM_RESEARCH_OFFICER "Research Officer"
#define JOB_CENTCOM_SPECIAL_OFFICER "Special Ops Officer"
#define JOB_CENTCOM_PRIVATE_SECURITY "Private Security Force"

#define JOB_GROUP_ENGINEERS list( \
	JOB_STATION_ENGINEER, \
	JOB_ATMOSPHERIC_TECHNICIAN, \
)


#define JOB_DISPLAY_ORDER_ASSISTANT 1
#define JOB_DISPLAY_ORDER_CAPTAIN 2
#define JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL 3
#define JOB_DISPLAY_ORDER_BARTENDER 4
#define JOB_DISPLAY_ORDER_BOTANIST 5
#define JOB_DISPLAY_ORDER_COOK 6
#define JOB_DISPLAY_ORDER_JANITOR 7
#define JOB_DISPLAY_ORDER_CLOWN 8
#define JOB_DISPLAY_ORDER_MIME 9
#define JOB_DISPLAY_ORDER_CURATOR 10
#define JOB_DISPLAY_ORDER_LAWYER 11
#define JOB_DISPLAY_ORDER_CHAPLAIN 12
#define JOB_DISPLAY_ORDER_PSYCHOLOGIST 13
#define JOB_DISPLAY_ORDER_AI 14
#define JOB_DISPLAY_ORDER_CYBORG 15
#define JOB_DISPLAY_ORDER_CHIEF_ENGINEER 16
#define JOB_DISPLAY_ORDER_STATION_ENGINEER 17
#define JOB_DISPLAY_ORDER_ATMOSPHERIC_TECHNICIAN 18
#define JOB_DISPLAY_ORDER_QUARTERMASTER 19
#define JOB_DISPLAY_ORDER_CARGO_TECHNICIAN 20
#define JOB_DISPLAY_ORDER_SHAFT_MINER 21
#define JOB_DISPLAY_ORDER_BITRUNNER 22
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 23
#define JOB_DISPLAY_ORDER_MEDICAL_DOCTOR 24
#define JOB_DISPLAY_ORDER_PARAMEDIC 25
#define JOB_DISPLAY_ORDER_CHEMIST 26
#define JOB_DISPLAY_ORDER_VIROLOGIST 27
#define JOB_DISPLAY_ORDER_CORONER 28
#define JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR 29
#define JOB_DISPLAY_ORDER_SCIENTIST 30
#define JOB_DISPLAY_ORDER_ROBOTICIST 31
#define JOB_DISPLAY_ORDER_GENETICIST 32
#define JOB_DISPLAY_ORDER_HEAD_OF_SECURITY 33
#define JOB_DISPLAY_ORDER_WARDEN 34
#define JOB_DISPLAY_ORDER_DETECTIVE 35
#define JOB_DISPLAY_ORDER_SECURITY_OFFICER 36
#define JOB_DISPLAY_ORDER_PRISONER 37

#define DEPARTMENT_UNASSIGNED "Без отдела"

#define DEPARTMENT_BITFLAG_SECURITY (1<<0)
#define DEPARTMENT_SECURITY "Охрана"
#define DEPARTMENT_BITFLAG_COMMAND (1<<1)
#define DEPARTMENT_COMMAND "Командование"
#define DEPARTMENT_BITFLAG_SERVICE (1<<2)
#define DEPARTMENT_SERVICE "Сервис"
#define DEPARTMENT_BITFLAG_CARGO (1<<3)
#define DEPARTMENT_CARGO "Грузы"
#define DEPARTMENT_BITFLAG_ENGINEERING (1<<4)
#define DEPARTMENT_ENGINEERING "Инженерия"
#define DEPARTMENT_BITFLAG_SCIENCE (1<<5)
#define DEPARTMENT_SCIENCE "Наука"
#define DEPARTMENT_BITFLAG_MEDICAL (1<<6)
#define DEPARTMENT_MEDICAL "Медицина"
#define DEPARTMENT_BITFLAG_SILICON (1<<7)
#define DEPARTMENT_SILICON "ИИ"
#define DEPARTMENT_BITFLAG_ASSISTANT (1<<8)
#define DEPARTMENT_ASSISTANT "Ассистент"
#define DEPARTMENT_BITFLAG_CAPTAIN (1<<9)
#define DEPARTMENT_CAPTAIN "Капитан"

/* Job datum job_flags */
/// Whether the mob is announced on arrival.
#define JOB_ANNOUNCE_ARRIVAL (1<<0)
/// Whether the mob is added to the crew manifest.
#define JOB_CREW_MANIFEST (1<<1)
/// Whether the mob is equipped through SSjob.EquipRank() on spawn.
#define JOB_EQUIP_RANK (1<<2)
/// Whether the job is considered a regular crew member of the station. Equipment such as AI and cyborgs not included.
#define JOB_CREW_MEMBER (1<<3)
/// Whether this job can be joined through the new_player menu.
#define JOB_NEW_PLAYER_JOINABLE (1<<4)
/// Whether this job appears in bold in the job menu.
#define JOB_BOLD_SELECT_TEXT (1<<5)
/// Reopens this position if we lose the player at roundstart.
#define JOB_REOPEN_ON_ROUNDSTART_LOSS (1<<6)
/// If the player with this job can have quirks assigned to him or not. Relevant for new player joinable jobs and roundstart antags.
#define JOB_ASSIGN_QUIRKS (1<<7)
/// Whether this job can be an intern.
#define JOB_CAN_BE_INTERN (1<<8)
/// This job cannot have more slots opened by the Head of Personnel (but admins or other random events can still do this).
#define JOB_CANNOT_OPEN_SLOTS (1<<9)

/// Combination flag for jobs which are considered regular crew members of the station.
#define STATION_JOB_FLAGS (JOB_ANNOUNCE_ARRIVAL|JOB_CREW_MANIFEST|JOB_EQUIP_RANK|JOB_CREW_MEMBER|JOB_NEW_PLAYER_JOINABLE|JOB_REOPEN_ON_ROUNDSTART_LOSS|JOB_ASSIGN_QUIRKS|JOB_CAN_BE_INTERN)

#define FACTION_NONE "None"
#define FACTION_STATION "Station"

// Variable macros used to declare who is the supervisor for a given job, announced to the player when they join as any given job.
#define SUPERVISOR_CAPTAIN "the Captain"
#define SUPERVISOR_CE "the Chief Engineer"
#define SUPERVISOR_CMO "the Chief Medical Officer"
#define SUPERVISOR_HOP "the Head of Personnel"
#define SUPERVISOR_HOS "the Head of Security"
#define SUPERVISOR_QM "the Quartermaster"
#define SUPERVISOR_RD "the Research Director"
