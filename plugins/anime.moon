anime = (msg,anime) ->
  url = "http://hummingbird.me/api/v1/search/anime?query=#{URL.escape anime}"
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

animepic = (msg,pic) ->
  url = "http://konachan.com/post.json?limit=200&tags=#{URL.escape pic}"
  jstr, res = https.request url
  jdat = JSON.decode jstr
  if jdat[1]
    random = math.random #jdat
    jdat = jdat[random]
    file = jdat.jpeg_url

    if msg.chat.type == "inline"
        block = "[#{inline_photo_block "#{file}", "#{file}", "AnimePic"}]"
        telegram!\sendInline msg.id, block
        return

    file_path = download_to_file file,"anime.jpg"
    telegram!\sendPhoto msg.chat.id,file_path
    os.remove file_path
    return
  else
    return "Nothing found"

animepicrn = (msg,picrn) ->
  url = "https://konachan.com/post.json?limit=200"
  jstr, res = http.request url
  jdat = JSON.decode jstr
  if jdat[1]
    random = math.random #jdat
    jdat = jdat[random]
    file = jdat.jpeg_url

    if msg.chat.type == "inline"
        block = "[#{inline_photo_block "#{file}", "#{file}", "AnimePic"}]"
        telegram!\sendInline msg.id, block
        return

    file_path = download_to_file file,"anime.jpg"
    telegram!\sendPhoto msg.chat.id,file_path
    os.remove file_path
    return
  return

run = (msg,matches) ->
    if matches[1] == "anime" and matches[2] == "search" and matches[3]
          return anime msg,matches[3]
    elseif matches[1] == "anime" and matches[2] == "pic" and matches[3]
          return animepic msg,matches[3]
    elseif matches[1] == "anime" and matches[2] == "pic"
          return animepicrn msg,picrn

return {
  description: "*Anime plugin (hummingbird.me)*"
  usage: [[
`/anime search [anime name]`
For searching
`/anime pic [query]`
Will search for query
`/anime pic`
Will send random anime pic
]]
  patterns: {
   "^[!/#](anime)(search) (.*)"
   "^[!/#](anime)(pic) (.*)"
   "^[!/#](anime)(pic)$"
   --Inline
   "^###inline[!/#](anime)(search) (.*)"
  }
  :run
}
