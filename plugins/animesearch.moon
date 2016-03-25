run = (msg,matches) ->
  url = "http://hummingbird.me/api/v1/search/anime?query=#{URL.escape matches[2]}"
  response, code, headers = http.request url
  if code ~= 200
    return "Error:  #{code} "
  if #response > 0
    jdat = JSON.decode response
    if jdat.Error
      return jdat.Error

    message = "[#{jdat[1].title}](http://myanimelist.net/anime/#{jdat[1].mal_id})
*Episodes*: #{jdat[1].episode_count}
*Status*: "
	message ..= "#{jdat[1].status}
*Aired*: "
	message ..= "#{string.sub(jdat[1].started_airing,0,4)}
*Genres*: "
	for i = 1,#jdat[1].genres
			if i == #jdat[1].genres
				message ..= "#{jdat[1].genres[i].name}"
	        else
				message ..= "#{jdat[1].genres[i].name}, "

	if jdat[1].age_rating
			message ..= "\n*Rating:* #{jdat[1].age_rating}"

	message ..= "\n*Score: * #{string.sub(jdat[1].community_rating,0,4)}"
	message ..= "\n\n`#{jdat[1].synopsis}`\n"
      
	if msg.chat.type == "inline"
        	block = "[#{inline_article_block "#{jdat[1].title}", "#{message}", "Markdown", true, "Episodes: #{jdat[1].episode_count}"}]"
        	telegram!\sendInline msg.id, block
        	return

    return message

return {
  description: "Search Hummingbird for anime results"
  usage: [[
`/animesearch query`
]]
  patterns: {
   "^[!/#](animesearch) (.*)"
   --Inline
   "^###inline[!/#](animesearch) (.*)"
  }
  :run
}
