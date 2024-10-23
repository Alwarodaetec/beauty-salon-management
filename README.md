# Beauty Salon Management

Este projeto é um sistema de gerenciamento para salões de beleza, com funcionalidades de agendamento, cadastro de clientes, profissionais e especialidades.

## Funcionalidades

- **Gerenciamento de Especialidades**: Cadastro de tipos de serviços prestados (manicure, cabeleireira, etc.).
- **Cadastro de Clientes**: Inserção de novos clientes com CPF.
- **Cadastro de Profissionais**: Inserção de profissionais com CPF e vinculação a especialidades.
- **Agendamento de Serviços**: Agendamento de serviços para clientes com um profissional específico.
- **Regras de Agendamento**: Não permite agendamentos para domingos e segundas-feiras.

## Estrutura do Banco de Dados

O sistema contém as seguintes tabelas:
- `especialidade_aps`: Armazena as especialidades oferecidas pelo salão.
- `profissional_aps`: Armazena os dados dos profissionais e suas especialidades.
- `cliente_aps`: Armazena os dados dos clientes.
- `servico_aps`: Armazena os agendamentos de serviços.

## Como Executar

1. Crie o banco de dados executando os scripts SQL fornecidos.
2. Use os procedimentos armazenados para inserir especialidades, clientes e profissionais.
3. Utilize o procedimento de agendamento para registrar os serviços.
4. A trigger impede agendamentos aos domingos e segundas-feiras.

## Exemplo de Uso

- **Inserção de Especialidades**:  
  ```sql
  CALL insere_nova_especialidade_aps('Manicure');
