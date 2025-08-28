#!/bin/bash

#Função para exportar uma branch
exporta_branch(){
    echo "Insira a URL do .git do repositório externo:"
    read repositorio
    echo "Qual branch externa você quer importar?"
    read branch
    echo "Qual branch local deve receber o merge?"
    read branch_sofre_merge

    # Add localmente o repositorio externo 
    git remote add externo $repositorio 2>/dev/null || echo "Remoto 'externo' já existe."
    # Exporta a branch remota para uma local temporaria
    git fetch externo $branch:branch_temp
    # Atualiza o repositorio origin (busca todas as branchs)
    git fetch origin
    # Troca para a branch de destino
    git switch $branch_sofre_merge
    # Junta a branch temporaria na branch destino
    git merge branch_temp
    # Atualiza o remoto com a branch destino atualizada
    git push origin $branch_sofre_merge
    # Limpa temporaria e repositorio externo (Somente local, em nenhum momento elas fazem parte do repositorio remoto origin)
    git branch -D branch_temp
    git remote remove externo

    echo "Branch externa '$branch' foi mesclada em '$branch_sofre_merge' e enviada para origin!"
}

exporta_branch