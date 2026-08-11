#!/bin/bash
echo 'Looking up specs labeled with "version_"...'
echo '' > app/views/project_management/index.html.erb
echo '<div class="scrollable">' >> app/views/project_management/index.html.erb
echo $'<%= link_to \'Return to Game\', root_path %>' >> app/views/project_management/index.html.erb
echo '<ul>' >> app/views/project_management/index.html.erb
grep -oPrh 'version_\K(.+)' spec/ | sort | sed "s/^/<li>v/" | sed "s/'$/<\/li>/" >> app/views/project_management/index.html.erb
echo '</ul>' >> app/views/project_management/index.html.erb
echo '</div>' >> app/views/project_management/index.html.erb
echo 'DONE'
