namespace :ssh do
  task :setup do
    on roles(:app) do
      host = fetch(:ssh_repo_host)
      user = fetch(:user)

      known_hosts = "~/known_hosts"
      known_hosts_path = "/home/#{user}/.ssh/known_hosts"

      sudo "ssh-keyscan -H #{host} >> #{known_hosts}"
      sudo "mv #{known_hosts} #{known_hosts_path}"

      key_path = fetch(:ssh_key_path)

      id_rsa = File.join(key_path, "id_rsa")
      id_rsa_pub = File.join(key_path, "id_rsa.pub")

      upload! id_rsa, "/tmp/id_rsa"
      upload! id_rsa_pub, "/tmp/id_rsa.pub"

      sudo "mv /tmp/id_rsa /home/#{user}/.ssh/id_rsa"
      sudo "mv /tmp/id_rsa.pub /home/#{user}/.ssh/id_rsa.pub"
      sudo "chmod 600 /home/#{user}/.ssh/id_rsa"
    end
  end
end
