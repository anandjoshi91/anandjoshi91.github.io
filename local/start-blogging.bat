echo "Opening Sublime text editor"

START "" "C:\Program Files\Sublime Text 3\sublime_text.exe"

echo "Starting Git bash"
START "" "C:\Program Files\Git\git-bash.exe"


cd ..
echo "Starting jekyll server..."
START /B /min jekyll serve --watch

timeout 3

start http://127.0.0.1:4000
cls


echo "Server is up on : http://127.0.0.1:4000 "

echo "Close this window to shutdown the server"


