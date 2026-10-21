#!/bin/bash
echo 'Looking up specs labeled with "version_"...'
echo '' > app/views/home/roadmap.html.erb
echo '<div class="scrollable">' >> app/views/home/roadmap.html.erb
echo $'<%= link_to \'Return to Game\', root_path %>' >> app/views/home/roadmap.html.erb
echo '<ul>' >> app/views/home/roadmap.html.erb
grep -oPrh 'version_\K(.+)' spec/ | sort | sed "s/^/<li>v/" | sed "s/'$/<\/li>/" >> app/views/home/roadmap.html.erb
echo '</ul>' >> app/views/home/roadmap.html.erb
echo '</div>' >> app/views/home/roadmap.html.erb
echo 'DONE'
