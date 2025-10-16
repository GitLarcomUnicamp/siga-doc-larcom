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
                    <td>${i.mob.idMobil}</td>
                    <td>${i.mob.dnmSigla}</td>
                    <td>${i.mob.descricao}</td>
                `;
                corpo.appendChild(tr);
            });
        } catch (e) {
            console.error("Erro ao carregar itens:", e);
        }
    }

        window.onload = carregarModelos;
    </script>
</head>
<body>
    <h2>Incluir Edital Eliminação</h2>

    <form id="formInclusao" method="post">
        <label for="selectMenu1">Modelo de Edital de Eliminação</label>
        <select id="selectMenu1" name="modEdital" onchange="carregarEditais()">
            <option value="">Carregando...</option>
        </select>

        <label for="selectMenu2">Editais</label>
        <select id="selectMenu2" name="edital" onchange="carregarAEliminar()">
            <option value="">-- Selecione um modelo primeiro --</option>
        </select>

        <table id="listaItens">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Código</th>
                    <th>Descrição</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </form>
</body>
</siga:pagina>