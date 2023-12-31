/proc/tts_speech_filter(text)
	// Only allow alphanumeric characters and whitespace
	var/static/regex/bad_chars_regex = regex("\[^a-zа-яA-ZА-Я0-9 ,?.!'&-]", "g")
	return bad_chars_regex.Replace(text, " ")
