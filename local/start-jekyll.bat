cd ..
echo "Starting jekyll server..."
START /B /min jekyll serve --watch

timeout 3

start http://127.0.0.1:4000
cls

echo
echo "Server is up on : http://127.0.0.1:4000 "
echo
echo "Close this window to shutdown the server"
echo