title = "rasmuserik.com"
entryMap =

  html5cnug:
    title: "Slides: HTML5"
    date: "2013-05-22"
    tags: "presentation, html5, cnug"
    links:
      Slides: "http://rasmuserik.com/html5/cnug2013-slides.html"
      Source: "https://github.com/rasmuserik/app-speeding"
    desc: "Slides for presentation done at CNUG.dk"
    time: "3 days study/preparation for presentation, 1 hour presentation"

  speeding:
    title: "Speeding visualisation"
    tags: "coffeescript, hammertime, visualisation"
    date: "2013-05-15"
    links:
      "Try it!": "http://speeding.solsort.com"
      Source: "https://github.com/rasmuserik/app-speeding"
    desc: "Visualiseringskode for vejdirektoratet - layout baseret på tidligere udgave"
    time: "5 hours trying to optimise original outsourced code, then 10 hours reimplementing it"

  Dragimation:
    date: "2013-04-30"
    tags: "coffeescript, hammertime, visualisation, html5"
    links:
      "Try it!": "http://dragimation.solsort.com"
      Source: "https://github.com/rasmuserik/app-dragimation"
    desc: "Dragging animation special effect - as requested for the development of legoland billund resort web page."

  CombiGame:
    links:
      "Try it!": "/_/combigame.com"
    desc: "Logical game, inspired by a card game"
    date: "2012-03-26"

  "Tsar Tnoc":
    link: "http://tsartnoc.solsort.com"
    desc: "Result of a ludum dare hackathon."
    date: "2012-07-15"

  BlobShot:
    link: "http://blobshot.solsort.com"
    desc: "Result of the 5apps hackathon."
    date: "2012-05-06"

  NoteScore:
    desc: "Note learning app"
    links:
      "Try it!": "http://old.solsort.com/#notescore"
      "Android App": "https://market.android.com/details?id=dk.solsort.notescore"
      Source: "https://github.com/rasmuserik/notescore"
    date: "2011-08"

  dkcities:
    title: "Danske Byer"
    link: "http://old.solsort.com/#dkcities"
    source: "https://github.com/rasmuserik/dkcities"
    desc: 'Learning "game" for the geography of Denmark.'
    date: "2011-08"

  CuteEngine:
    link: "/_/solsort.dk/planetcute"
    source: "https://github.com/rasmuserik/planetcute"
    desc: "Game engine experiment"
    date: "2011-08"
    time: "3 days"

  biweekly:
    kind: "html"
    title: "solsort.com status"
    desc: "Biweekly status for solsort.com company startup"
    date: "2013"

  "Productivity Hacks":
    kind: "html"
    title: "solsort.com status"
    desc: "Notes for a presentation on productivity hacks. Keywords of my aproaches to handle the world."
    date: "2013-04-30"

  "EuroCards":
    tags: "card game"
    desc: "top-trump like card game for learning facts about european countries"
    date: "2012-06-20"

  "Pricing scale":
    kind: "html"
    desc: "Tool for pricing and estimating cost."
    date: "2013"

  "Skrivetips":
    kind: "html"
    lang: "da"
    desc: "Tips / noter om skrivning, herunder også struktur for videnskabelige rapporter. Tips for effective writing (in Danish)."
    date: "2005"

  "Presentation evaluation notes":
    kind: "html"
    desc: "Checklist / notes for giving feedback on presentations. Useful for Toastmasters and similar."
    date: "2012-03-18"

  # Master thesis
  # sourceforge image transform pocr
  # lightscript 2
  # yolan 2
  # BSc. thesis
  # Filtering contexts paper
  # Tempo paper
  # Poetry
  # Graphics
  # Music
  # Photo albums
  # Rasmus Erik
  # CV

Entry = (obj) ->
  for key, val of obj
    console.log key, val
    this[key] = val
  this

Entry.prototype.moveTo = (x,y,size,delay) ->
  size = @size if not size
  delay = @delay if not delay
  style = @elem.style
  setPos = ->
    style.left = x + "px"
    style.top = y + "px"
  if @size isnt size
    style.width = style.height = size + "px"
    style.borderRadius = size/2 + "px"
    @size = size
  [@x, @y] = [x, y]
  if @delay isnt delay
    style.webkitTransition = "all #{delay}ms"
    style.transition = "all #{delay}ms"
    @delay = delay
    setTimeout setPos, 0
  else
    setPos()

isServer = if typeof process is "object" then true else false

if isServer
  fs = require "fs"

toUrl = (str) ->
  str = str.toLowerCase()
  str.replace /[^a-zA-Z0-9]/g, "-"

entries = for key, val of entryMap
  obj = new Entry(val)
  console.log "U", obj, val
  entryMap[key] = obj
  obj.title = obj.title or key
  obj.name = obj.name or toUrl key
  if isServer
    obj.imgtype = if (require "fs").existsSync "#{__dirname}/images/#{obj.name}.jpg" then "jpg" else "png"
  console.log obj, "missing date" if not obj.date
  entryMap[obj.name] = obj
entries.sort (a, b) -> if a.date < b.date then 1 else -1

if isServer
  console.log entries.map (obj)->[obj.name, obj.imgtype]
entryHTML = (entry) ->
  "<span id=#{entry.name} class=entry>" +
    "<img src=\"images/#{entry.name}.#{entry.imgtype}\">" +
  "</span>"

genHTML = ->
  "<!DOCTYPE html>" +
  "<html><head>" +
    "<title>#{title}</title>" +
    '<script src="main.js"></script>' +
  "</head>" +
  "<body>" +
    ((entries.map entryHTML).join "") +
    '<script>main()</script>' +
  "</body></html>"

fs.writeFileSync __dirname + "/index.html", genHTML(), "utf8" if isServer
# process combile main.coffee
#console.log genHTML()

hexHeight = Math.sqrt(3)/2
hexPos = (x, y) ->
  x -= 0.5 if y & 1
  return [x + .5, y*hexHeight ]
 
width = height = 0
updateDim = ->
  width = window.innerWidth
  height = window.innerHeight

updateDim() if not isServer
  

hexLayout = (nodes) ->
  console.log nodes
  nwidth = Math.floor(Math.sqrt(nodes.length * width / height * hexHeight))
  nrows = Math.ceil(nodes.length / (nwidth + .5))
  maxsize = Math.min(width/nwidth, height/nrows)

  margin = maxsize * .05
  size = maxsize * .9
  n = 0
  x = 0
  y = 0
  for node in nodes
    [x0, y0] = hexPos x,y
    console.log x0, y0
    node.elem.style.left = "#{x0*(size+2*margin)+margin}px"
    node.elem.style.top = "#{y0*(size+2*margin)+margin}px"
    node.elem.style.width = "#{size}px"
    node.elem.style.height = "#{size}px"
    x0 = x0*(size+2*margin)+margin
    y0 = y0*(size+2*margin)+margin
    console.log "X", node
    node.moveTo(x0,y0,size)
    ++x
    if x >= nwidth + (y & 1)
      ++y
      x = 0

borderLayout = (nodes) ->
  size = Math.min(Math.ceil(2*(width+height)/(nodes.length+8)), width * .2, height * .2)
  for node in nodes
    node.moveTo(node.x, node.y, size * 0.8, 3000)

this.main = ->
  for elem in document.getElementsByClassName "entry"
    img = elem.children[0]
    entryMap[elem.id].elem = elem
    entryMap[elem.id].img = img
    elemstyle = elem.style
    elemstyle.position = "absolute"
    elemstyle.width = "10px"
    elemstyle.height = "10px"
    elemstyle.borderRadius = "50px"
    elemstyle.boxShadow = "4px 4px 8px rgba(0,0,0,0.6) inset"
    elemstyle.border = "1px solid rgba(255,255,255,0.3)"
    elemstyle.top = Math.random() * 400 + "px"
    elemstyle.left = Math.random() * 400 + "px"
    imgstyle = img.style
    imgstyle.borderRadius = "1000px"
    imgstyle.position = "absolute"
    imgstyle.zIndex = "-1"
    imgstyle.width = "100%"
    imgstyle.height = "100%"

  bgColor = [200 + Math.random() * 55, 200 + Math.random() * 55, 200 + Math.random() * 55]
  animateBackground = ->
    bgColor[0] = Math.round(Math.min(255, Math.max(0, bgColor[0] + 6*Math.random() - 3)))
    bgColor[1] = Math.round(Math.min(255, Math.max(0, bgColor[1] + 6*Math.random() - 3)))
    bgColor[2] = Math.round(Math.min(255, Math.max(0, bgColor[2] + 6*Math.random() - 3)))
    document.body.style.backgroundColor = "rgb("+bgColor+")"
    #col = -> Math.floor 0 + Math.random() * 255
    #bodystyle = document.body.style
    #bodystyle.backgroundColor = "rgb(#{[col(),col(),col()]})"
    #bodystyle.webkitTransition = "all 30s"
    #bodystyle.transition = "all 30s"
    #setTimeout animateBackground, 1000
  animateBackground()
  hexLayout(entries)
  setTimeout (->borderLayout entries), 3000

  window.onresize = -> 
    updateDim()
    hexLayout(entries)

