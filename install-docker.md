# run installation script
curl -sSL https://get.docker.com | sh

# add current user to docker group
sudo usermod -aG docker melbayat

# download portainer image
sudo docker pull portainer/portainer-ce:linux-arm

# run portainer container
sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:linux-arm

# docker cheat sheet
run -d                              <!-- for deattached , won't hold up the terminal -->
run -p                              <!-- port -->
--restart                           <!-- always to start when rebooted, or unless-stopped -->
-v                                  <!-- variable -->
sudo docker rm portainer            <!-- remove a container -->
docker ps                           <!-- list containers -->
docker ps -a                        <!-- including stopped ones -->
docker logs <container_id>
docker stop <container_id>
docker run -it <container_name>