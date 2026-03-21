# Rently

Sistema web de gerenciamento de locação de automóveis. Permite que clientes solicitem aluguéis, agentes da locadora avaliem os pedidos e bancos associem contratos de crédito.

## Atores

| Ator | Responsabilidade |
|---|---|
| **Cliente** | Cria, edita e cancela pedidos de aluguel |
| **Agente (Empresa/Banco)** | Avalia pedidos e executa contratos |
| **Banco** | Associa contrato de crédito a pedidos aprovados |

## Fluxo principal

1. Visitante se cadastra e faz login
2. Cliente cria um pedido selecionando um automóvel disponível
3. Agente analisa o pedido e registra parecer (aprovado/recusado)
4. Se aprovado, o contrato de aluguel é executado — podendo ser financiado por um banco
5. O tipo de propriedade do veículo é registrado (cliente, empresa ou banco)

## Licença

Distribuído sob a licença [MIT](LICENSE).

## Diagramas

- [Casos de Uso](docs/Casos%20de%20Uso/Diagrama%20-%20Casos%20de%20Uso.png)
- [Classes](docs/Classes/Diagrama%20-%20Classes.png)
- [Pacotes](docs/Pacotes/Diagrama%20-%20Pacotes.png)
