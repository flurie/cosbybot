cosbybot
========

next generation utopia data collector and aggregator (cf. http://utopia-game.com)

todo tasks:

- parsers
  * sos parser
  * survey parser
  * op parser
  * kingdom page parser
  * (extra) news parser
  * (extra) chart parser
- session handling
  * cookies for origin (required for parsers)
  * cookies for authentication (eliminate CSRF holes currently in existence)
- bot
  * communicate with site/dbs
  * forward irc chat to whatsapp (maybe separate channel?)
  * (extra) !can-i-hit command, automagically tells you which provs you can hit leaving x def
- site
  * basic intel viewing
  * more complicated intel viewing
  * charts
  * predictive measures for canonical prov data (e.g. autoadd ops, autoadd training, autoadd land and armies home)
  * (extra) irc chat
