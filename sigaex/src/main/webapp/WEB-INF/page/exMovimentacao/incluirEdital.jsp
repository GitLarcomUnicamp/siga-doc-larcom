<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://localhost/jeetags" prefix="siga"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<siga:pagina titulo="Movimentação">
<head>
    <script type="text/javascript">
        async function carregarModelos() {
            const select = document.getElementById("selectMenu1");

            try {
                const response = await fetch("/sigaex/app/expediente/mov/listarModelos");
                const modelos = await response.json();

                select.innerHTML = '<option value="">-- Selecione --</option>';

                modelos.forEach(m => {
                    const opt = document.createElement("option");
                    opt.value = m.idMod;
                    opt.textContent = m.nmMod;
                    select.appendChild(opt);
                });
            } catch (e) {
                console.error("Erro ao carregar modelos:", e);
            }
        }

        async function carregarEditais() {
            const select1 = document.getElementById("selectMenu1");
            const select2 = document.getElementById("selectMenu2");
            const idMod = select1.value;

            select2.innerHTML = '<option value="">Carregando...</option>';

            if (!idMod) {
                select2.innerHTML = '<option value="">-- Selecione um modelo primeiro --</option>';
                return;
            }

            try {
                const response = await fetch("/sigaex/app/expediente/mov/listarEditais", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "idModEdital=" + encodeURIComponent(idMod)
                });

                const editais = await response.json();

                select2.innerHTML = '<option value="">-- Selecione o edital --</option>';
                editais.forEach(e => {
                    const opt = document.createElement("option");
                    opt.value = e.idMobil;
                    opt.textContent = e.dnmSigla;
                    select2.appendChild(opt);
                });
            } catch (e) {
                console.error("Erro ao carregar editais:", e);
                select2.innerHTML = '<option value="">Erro ao carregar</option>';
            }
        }

        async function carregarAEliminar() {
        const siglaEdital = document.getElementById("selectMenu2").value;
        const tabela = document.getElementById("listaItens");
        const corpo = tabela.querySelector("tbody");

        if (!siglaEdital) {
            tabela.style.display = "none";
            return;
        }

        const formData = new FormData();
        formData.append("siglaEdital", siglaEdital);

        try {
            const response = await fetch("/sigaex/app/expediente/mov/listarAEliminar", {
                method: "POST",
                body: formData
            });
            const itens = await response.json();

            corpo.innerHTML = "";

            itens.forEach(i => {
                const tr = document.createElement("tr");
                tr.innerHTML = `
                    <td align="center">\${i.mob.idMobil}</td>
                    <td align="center"><a href="/sigaex/app/expediente/doc/exibir?sigla=\${i.mob.dnmSigla}">\${i.mob.dnmSigla}</a></td>
                    <td align="center">\${i.mob.descricao}</td>
                    <input type="checkbox" align="center" name="selecionado" value="\${i.mob.idMobil}">
                `;
                corpo.appendChild(tr);
            });

            tabela.style.display = "table";
        } catch (e) {
            console.error("Erro ao carregar itens:", e);
        }
    }

    async function incluir() {
        
    }

        window.onload = carregarModelos;
    </script>
</head>
<body class="container-fluid content">
    <h2 class="row">Incluir Edital Eliminação</h2>

    <div>
        <form id="formInclusao" method="post">
            <label for="selectMenu1">Modelo de Edital de Eliminação</label>
            <select id="selectMenu1" name="modEdital" onchange="carregarEditais()">
                <option value="">Carregando...</option>
            </select>

            <label for="selectMenu2">Editais</label>
            <select id="selectMenu2" name="edital" onchange="carregarAEliminar()">
                <option value="">-- Selecione um modelo primeiro --</option>
            </select>
            <button class="btn btn-primary" type="button" onclick="incluir()">Incluir</button>

            <table class="table table-sm table-hover" id="listaItens" style="display:none;">
                <thead class="thead-light">
                    <tr>
                        <th align="center">ID</th>
                        <th align="center">Código</th>
                        <th align="center">Descrição</th>
                        <th align="center">Incluir</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </form>
    </div>
</body>
</siga:pagina>