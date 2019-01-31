1. 
alias server='open http://localhost:8000 && python -m SimpleHTTPServer'

2.
npm install serve -g
serve -p 3000

3.
# put this in ~/.profile or whatever u use
server() {
  open "http://localhost:${1}" && python -m SimpleHTTPServer $1
}

E.g.
$ server 8080
