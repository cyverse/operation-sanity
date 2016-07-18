echo "testing main Atmosphere functionality"
behave cloud.feature
echo "done"

echo "testing ticketing system"
behave check_featured.feature
echo "done"

echo "launching featured images"
behave --processes 2 --parallel-element scenario features/launch_featured.feature
echo "done"

echo "waiting 30 minutes for deployment to complete"
sleep 1800

echo "checking featured images"
behave --processes 2 --parallel-element scenario features/check_featured.feature
echo "done"

echo "cleaning up"
behave --processes 2 --parallel-element scenario features/delete_featured.feature
echo "done"