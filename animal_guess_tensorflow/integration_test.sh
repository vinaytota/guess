TEST_MODE=1 python -m scripts.train
TEST_MODE=1 python -m scripts.server &
sleep 5 # wait for server startup
APP_PID=$!
python -m test.test_server
kill $APP_PID