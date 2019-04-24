## gitlab-runner
一句话脚本,会自动退出，还在找原因
```
docker run -d -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner register \
  --non-interactive \
  --executor "docker" \
  --docker-image alpine:3 \
  --url "https://gitlab.cugapp.com/" \
  --registration-token "tooooooken" \
  --description "docker-runner" \
  --tag-list "docker,aws,1C2G" \
  --run-untagged \
  --locked="false"
```