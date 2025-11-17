<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/customtag" prefix="tags"%>
<%@ taglib uri="http://localhost/jeetags" prefix="siga"%>

<siga:pagina titulo="Eliminação">
    <div class="container-fluid">
        <div class="card bg-light mb-3">
            <h2 class="card-header">Efetivação da Exclusão via Termo de Eliminação</h2>
            <div class="card-body">
                <form id="formInclusao" method="post">
                <label for="selectMenu1">Modelo de Termo de Eliminação</label><br>
                <select id="selectMenu1" name="modTermo" onchange="carregarTermos()">
                    <option value="">Carregando...</option>
                </select><br><br>

                <label for="selectMenu2">Termos</label><br>
                <select id="selectMenu2" name="termo">
                    <option value="">-- Selecione um modelo primeiro --</option>
                </select><br><br>

                <button class="btn btn-primary" type="button" id="btnExcluir">
                    Efetuar Exclusão
                </button>
                </form>
            </div>
        </div>

        <script>
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
                    select.innerHTML = '<option value="">Erro ao carregar</option>';
                }
            }

            async function carregarTermos() {
            const idMod = document.getElementById("selectMenu1").value;
            const select2 = document.getElementById("selectMenu2");
            select2.innerHTML = '<option value="">Carregando...</option>';

            if (!idMod) {
                select2.innerHTML = '<option value="">-- Selecione um modelo primeiro --</option>';
                return;
            }

                try {
                    const response = await fetch("/sigaex/app/expediente/mov/listarInstanciaModelos", {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: "idModInstancia=" + encodeURIComponent(idMod)
                    });

                    const termos = await response.json();
                    select2.innerHTML = '<option value="">-- Selecione um termo --</option>';

                    termos.forEach(e => {
                        const opt = document.createElement("option");
                        opt.value = e.dnmSigla;
                        opt.textContent = e.dnmSigla;
                        select2.appendChild(opt);
                    });
                } catch (e) {
                    console.error("Erro ao carregar termos:", e);
                    select2.innerHTML = '<option value="">Erro ao carregar</option>';
                }
            }

            async function efetuarExclusao() {
                const termo = document.getElementById("selectMenu2").value;

                if (!termo) {
                    alert("Selecione um termo antes de efetuar a exclusão!");
                    return;
                }

                if (!confirm("Confirma a exclusão do termo selecionado?")) return;

                try {
                    const response = await fetch("/sigaex/app/expediente/mov/excluirInclusosPeriodoTermo", {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: "siglaTermo=" + encodeURIComponent(termo)
                    });

                    if (response.ok) {
                        alert("Exclusão efetuada com sucesso!");
                        document.getElementById("selectMenu2").value = "";
                    } else {
                        const msgErro = await response.text(); 
                        alert("Erro: " + msgErro);
                    }
                } catch (e) {
                    console.error("Erro na exclusão:", e);
                    alert("Falha na comunicação com o servidor.");
                }
            }

            document.getElementById("btnExcluir").addEventListener("click", efetuarExclusao);
            window.onload = carregarModelos;
        </script>
    </div>

</siga:pagina>