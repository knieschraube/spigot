# spigot-docker
### Example docker-compose.yml

```
version: '3.2'
services:
  spigot:
    image: knieschraube/spigot:v0.2
    restart: always
    ports:
      - 25565:25565
    environment:
      - SPIGOT_VER=latest
      - SPIGOT_EULA=true
    volumes:
      - spigot:/minecraft

volumes:
  spigot:
  ```
