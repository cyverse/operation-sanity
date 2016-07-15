echo "testing main Atmosphere functionality"
behave cloud.feature
echo "done"
echo "testing ticketing system"
behave check_featured.feature
echo "done"

echo "launching featured images"
behave --processes 2 --parallel-element scenario features/launch_featured.feature
echo "done"

echo "cleaning up"
behave --processes 2 --parallel-element scenario features/delete_featured.feature
echo "done"