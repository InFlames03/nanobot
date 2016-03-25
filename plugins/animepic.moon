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
    if matches[1] == "animepic" and matches[2]
          return animepic msg,matches[3]
    elseif matches[1] == "animepic"
          return animepicrn msg,picrn

return {
  description: "Get pictures from Konachan"
  usage: [[
By tag:
`/animepic [query]`
Random:
`/animepic`
]]
  patterns: {
   "^[!/#](animepic) (.*)"
   "^[!/#](animepic)$"
  }
  :run
}
