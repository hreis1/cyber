require 'httparty'
require 'json'

# Configurações do Bitcoin Core
rpc_user = 'seu_usuario'  # Defina o usuário configurado no bitcoin.conf
rpc_password = 'sua_senha'  # Defina a senha configurada no bitcoin.conf
rpc_host = '127.0.0.1'  # O Bitcoin Core está rodando na máquina local
rpc_port = '8332'  # Porta padrão RPC do Bitcoin Core

# Endereço do qual queremos consultar o saldo
address = '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa'  # Substitua com o endereço desejado

# URL da API RPC
rpc_url = "http://#{rpc_user}:#{rpc_password}@#{rpc_host}:#{rpc_port}"

# Função para realizar a chamada RPC utilizando HTTParty
def call_rpc(rpc_url, method, params = [])
  # Faz a requisição POST usando HTTParty
  response = HTTParty.post(rpc_url,
                           headers: { "Content-Type" => "application/json" },
                           body: {
                             jsonrpc: "1.0",
                             id: "ruby_client",
                             method: method,
                             params: params
                           }.to_json)

  # Retorna a resposta como um hash Ruby
  response.parsed_response
end

# Exemplo de chamada RPC para consultar o saldo de um endereço específico (getreceivedbyaddress)
response = call_rpc(rpc_url, 'getreceivedbyaddress', [address])

# Exibe o response completo
puts "Resposta Completa RPC: #{JSON.pretty_generate(response)}"

# Se houver erro, exibe a mensagem
if response['error']
  puts "Erro RPC: #{response['error']}"
else
  # Exibe o saldo
  puts "Saldo do endereço #{address}: #{response['result']} BTC"
end
