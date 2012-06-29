((b) ->
  x = /(^|["'(\s]|&lt;)(www\..+?\..+?)((?:[:?]|\.+)?(jpg|png|bmp|jpeg|gif)(?:\s|$)|&gt;|[)"',])/g
  y = /(^|["'(\s]|&lt;)((?:(?:https?|ftp):\/\/|mailto:).+?)((?:[:?]|\.+)?(jpg|png|bmp|jpeg|gif)(?:\s|$)|&gt;|[)"',])/g
  z = (h) ->
    if h.match(/.*(http.*jpg|png|bmp|jpeg|gif)/)
      h.replace(x, "$1<a href=\"<``>://$2$3\"><img src=\"<``>://$2$3\" onerror=\"swapFailedToLoadImage(this) \" height=\"200\" class=\"imageified\" /></a>").replace(y, "$1<a href=\"$2$3\"><img src=\"$2$3\" onerror=\"swapFailedToLoadImage(this) \" height=\"200\" class=\"imageified\" /></a>").replace /"<``>/g, "\"http"
    else
      h

  s = b.fn.imageify = (c) ->
    unless b.isPlainObject(c)
      c =
        use: (if (typeof c is "string") then c else `undefined`)
        handleLinks: (if b.isFunction(c) then c else arguments[1])
    d = c.use
    k = s.plugins or {}
    l = [ z ]
    f = undefined
    m = []
    n = c.handleLinks
    if d is `undefined` or d is "*"
      for i of k
        l.push k[i]
    else
      d = (if b.isArray(d) then d else b.trim(d).split(RegExp(" *, *")))
      o = undefined
      i = undefined
      p = 0
      A = d.length

      while p < A
        i = d[p]
        o = k[i]
        l.push o  if o
        p++
    @each ->
      h = @childNodes
      t = h.length
      while t--
        e = h[t]
        if e.nodeType is 3
          a = e.nodeValue
          if a.length > 1 and /\S/.test(a)
            q = undefined
            r = undefined
            f = f or b("<div/>")[0]
            f.innerHTML = ""
            f.appendChild e.cloneNode(false)
            u = f.childNodes
            v = 0
            g = undefined

            while (g = l[v])
              w = u.length
              j = undefined
              while w--
                j = u[w]
                if j.nodeType is 3
                  a = j.nodeValue
                  if a.length > 1 and /\S/.test(a)
                    r = a
                    a = a.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
                    a = (if b.isFunction(g) then g(a) else a.replace(g.re, g.tmpl))
                    q = q or r isnt a
                    r isnt a and b(j).after(a).remove()
              v++
            a = f.innerHTML
            if n
              a = b("<div/>").html(a)
              m = m.concat(a.find("a").toArray().reverse())
              a = a.contents()
            q and b(e).after(a).remove()
        else arguments.callee.call e  if e.nodeType is 1 and not /^(a|button|textarea)$/i.test(e.tagName)

    n and n(b(m.reverse()))
    this
) jQuery
