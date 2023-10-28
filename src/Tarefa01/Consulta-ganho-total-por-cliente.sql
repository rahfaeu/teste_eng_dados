select 
    cliente.nome as cliente_nome
    , round(
        sum(
            (
                contrato.percentual * (
                    transacao.valor_total * (
                        1 - isnull(transacao.percentual_desconto, 0) / 100
                    )
                )
            ) / 100
        )
        , 2
    ) as valor
from contrato
    inner join transacao on contrato.contrato_id = transacao.contrato_id
    inner join cliente on contrato.cliente_id = cliente.cliente_id
where contrato.ativo = 'true'
group by cliente.nome