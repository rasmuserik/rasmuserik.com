// Generated by CoffeeScript 1.6.2
(function() {
  var entries, entryHTML, entryMap, fs, genHTML, isServer, key, obj, title, toUrl;

  title = "rasmuserik.com";

  entryMap = {
    html5cnug: {
      title: "Slides: HTML5",
      date: "2013-05-22",
      tags: "presentation, html5, cnug",
      links: {
        Slides: "http://rasmuserik.com/html5/cnug2013-slides.html",
        Source: "https://github.com/rasmuserik/app-speeding"
      },
      desc: "Slides for presentation done at CNUG.dk",
      time: "3 days study/preparation for presentation, 1 hour presentation"
    },
    speeding: {
      title: "Speeding visualisation",
      tags: "coffeescript, hammertime, visualisation",
      date: "2013-05-15",
      links: {
        "Try it!": "http://speeding.solsort.com",
        Source: "https://github.com/rasmuserik/app-speeding"
      },
      desc: "Visualiseringskode for vejdirektoratet - layout baseret på tidligere udgave",
      time: "5 hours trying to optimise original outsourced code, then 10 hours reimplementing it"
    },
    Dragimation: {
      date: "2013-04-30",
      tags: "coffeescript, hammertime, visualisation, html5",
      links: {
        "Try it!": "http://dragimation.solsort.com",
        Source: "https://github.com/rasmuserik/app-dragimation"
      },
      desc: "Dragging animation special effect - as requested for the development of legoland billund resort web page."
    },
    CombiGame: {
      links: {
        "Try it!": "/_/combigame.com"
      },
      desc: "Logical game, inspired by a card game",
      date: "2012-03-26"
    },
    "Tsar Tnoc": {
      link: "http://tsartnoc.solsort.com",
      desc: "Result of a ludum dare hackathon.",
      date: "2012-07-15"
    },
    BlobShot: {
      link: "http://blobshot.solsort.com",
      desc: "Result of the 5apps hackathon.",
      date: "2012-05-06"
    },
    NoteScore: {
      desc: "Note learning app",
      links: {
        "Try it!": "http://old.solsort.com/#notescore",
        "Android App": "https://market.android.com/details?id=dk.solsort.notescore",
        Source: "https://github.com/rasmuserik/notescore"
      },
      date: "2011-08"
    },
    dkcities: {
      title: "Danske Byer",
      link: "http://old.solsort.com/#dkcities",
      source: "https://github.com/rasmuserik/dkcities",
      desc: 'Learning "game" for the geography of Denmark.',
      date: "2011-08"
    },
    CuteEngine: {
      link: "/_/solsort.dk/planetcute",
      source: "https://github.com/rasmuserik/planetcute",
      desc: "Game engine experiment",
      date: "2011-08",
      time: "3 days"
    },
    biweekly: {
      kind: "html",
      title: "solsort.com status",
      desc: "Biweekly status for solsort.com company startup",
      date: "2013"
    },
    "Productivity Hacks": {
      kind: "html",
      title: "solsort.com status",
      desc: "Notes for a presentation on productivity hacks. Keywords of my aproaches to handle the world.",
      date: "2013-04-30"
    },
    "EuroCards": {
      tags: "card game",
      desc: "top-trump like card game for learning facts about european countries",
      date: "2012-06-20"
    },
    "Pricing scale": {
      kind: "html",
      desc: "Tool for pricing and estimating cost.",
      date: "2013"
    },
    "Skrivetips": {
      kind: "html",
      lang: "da",
      desc: "Tips / noter om skrivning, herunder også struktur for videnskabelige rapporter. Tips for effective writing (in Danish).",
      date: "2005"
    },
    "Presentation evaluation notes": {
      kind: "html",
      desc: "Checklist / notes for giving feedback on presentations. Useful for Toastmasters and similar.",
      date: "2012-03-18"
    }
  };

  isServer = typeof process === "object" ? true : false;

  if (isServer) {
    fs = require("fs");
  }

  toUrl = function(str) {
    str = str.toLowerCase();
    return str.replace(/[^a-zA-Z0-9]/g, "-");
  };

  entries = (function() {
    var _results;

    _results = [];
    for (key in entryMap) {
      obj = entryMap[key];
      obj.title = obj.title || key;
      obj.name = obj.name || toUrl(key);
      if (isServer) {
        obj.imgtype = fs.existsSync("" + __dirname + "/images/" + obj.name + ".jpg") ? "jpg" : "png";
      }
      if (!obj.date) {
        console.log(obj, "missing date");
      }
      _results.push(entryMap[obj.name] = obj);
    }
    return _results;
  })();

  entries.sort(function(a, b) {
    if (a.date < b.date) {
      return 1;
    } else {
      return -1;
    }
  });

  if (isServer) {
    console.log(entries.map(function(obj) {
      return [obj.name, obj.imgtype];
    }));
  }

  entryHTML = function(entry) {
    return ("<span id=" + entry.name + " class=entry>") + ("<img src=\"images/" + entry.name + "." + entry.imgtype + "\">") + "<h1>obj.name</h1>" + "</span>";
  };

  genHTML = function() {
    return "<!DOCTYPE html>" + "<html><head>" + ("<title>" + title + "</title>") + '<script src="main.js"></script>' + "</head>" + "<body>" + ((entries.map(entryHTML)).join("")) + '<script>main()</script>' + "</body></html>";
  };

  if (isServer) {
    fs.writeFileSync(__dirname + "/index.html", genHTML(), "utf8");
  }

  this.main = function() {
    var animateBackground, elem, elemstyle, img, imgstyle, _i, _len, _ref;

    _ref = document.getElementsByClassName("entry");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      elem = _ref[_i];
      img = elem.children[0];
      entryMap[elem.id].elem = elem;
      entryMap[elem.id].img = img;
      elemstyle = elem.style;
      elemstyle.position = "absolute";
      elemstyle.width = "100px";
      elemstyle.height = "100px";
      elemstyle.borderRadius = "50px";
      elemstyle.boxShadow = "2px 2px 5px rgba(0,0,0,.2)";
      elemstyle.overflow = "hidden";
      elemstyle.top = Math.random() * 400 + "px";
      elemstyle.left = Math.random() * 400 + "px";
      imgstyle = img.style;
      imgstyle.width = "100%";
      imgstyle.height = "100%";
    }
    animateBackground = function() {
      var bodystyle, col;

      col = function() {
        return Math.floor(210 + Math.random() * 45);
      };
      bodystyle = document.body.style;
      bodystyle.backgroundColor = "rgb(" + [col(), col(), col()] + ")";
      bodystyle.webkitTransition = "all 10s";
      bodystyle.transition = "all 10s";
      return setTimeout(animateBackground, 10000);
    };
    return animateBackground();
  };

}).call(this);
