<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	buffer="64kb"%>
<%@ taglib uri="http://localhost/jeetags" prefix="siga"%>
<%@ taglib uri="http://localhost/libstag" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="/siga/bootstrap/css/bootstrap.min.css"	type="text/css" media="screen, projection, print" />

<script type="text/javascript">

    function validarNome(campo) {
        campo.value = campo.value.replace(/[^a-zA-ZàáâãéêíóôõúçÀÁÂÃÉÊÍÓÔÕÚÇ 0-9.\-\/]/g,'');
    }

    function validarEmail(campo) {
        if(campo.value !== "") {
            const RegExp = /\b[\w]+@[\w-]+\.[\w]+/;

            if (campo.value.search(RegExp) === -1) {
                sigaModal.alerta("E-mail inválido!");
                habilitarBotaoOk();
                document.getElementById('email').focus();
                return false;
            } else if (campo.value.search(',') > 0) {
                sigaModal.alerta("E-mail inválido! Não pode conter vírgula ( , )");
                habilitarBotaoOk();
                document.getElementById('email').focus();
                return false;
            } 
            return true;
        } else {
            return false;
        }
    }

	function verificarPreenchimentoTodosEmails() {
		var todosEmailsPreenchidos = true;
		var emails = document.querySelectorAll('input[type="email"]'); // Seleciona todos os campos de e-mail
	
		// Verifica cada campo de e-mail para ver se está vazio
		emails.forEach(function(email) {
			if (email.value.trim() === "") {
				todosEmailsPreenchidos = false;
			}
		});
		
		if(document.getElementById('nmPessoa').value ===""){
			todosEmailsPreenchidos = false;
		}

		// Habilita ou desabilita o botão baseado na variável 'todosEmailsPreenchidos'
		document.getElementById('btnEnviar').disabled = !todosEmailsPreenchidos;
	}
	
	let emailCount=0;
	
    function AdicionarEmail() {
		document.getElementById('btnEnviar').disabled = true;
		emailCount++;
		var newEmailHtml = `<div class="row mb-2 align-items-center" id="emailRow${emailCount}">
			<div class="col-sm-10">
				<div class="form-group">
					<label for="addEmail${emailCount}">E-mail: ${emailCount}</label>
					<input type="email" id="addEmail${emailCount}" name="addEmail" value="" maxlength="60"
						   onchange="validarEmail(this)" onkeyup="this.value = this.value.toLowerCase().trim()"
						   class="form-control" oninput="verificarPreenchimentoTodosEmails()"/>
				</div>
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-danger" onclick="RemoverEmail(${emailCount})">
					<i class="fas fa-trash-alt"></i>
				</button>
			</div>
		</div>`;

		//var newEmailHtml = `<div class="row" id="emailRow${emailCount}">
			//<div class="col-sm-12 d-flex">
				//<div class="form-group flex-grow-1">
					//<label for="addEmail${emailCount}">E-mail:${emailCount} </label>
					//<input type="email" id="addEmail${emailCount}" name="addEmail" value="" maxlength="60"
						  //onchange="validarEmail(this)" onkeyup="this.value = this.value.toLowerCase().trim()"
						  // class="form-control" oninput="verificarPreenchimentoTodosEmails()"/>
				//</div>
			//</div>
			//<div class="col-sm-2">
            	//<button type="button" class="btn btn-danger align-self-end ml-2" onclick="RemoverEmail(${emailCount})"><i class="fas fa-trash-alt"></i></button>
        	//</div>
		//</div>`;
	
		// Seleciona o elemento onde os e-mails estão sendo adicionados.
		var emailForm = document.getElementById("emailEntries");
	
		// Insere o novo campo de e-mail antes do botão de envio
		emailForm.insertAdjacentHTML('beforeend', newEmailHtml);
	}

	function RemoverEmail(id) {
		var emailRow = document.getElementById(`emailRow${id}`);
		emailRow.remove();
		verificarPreenchimentoTodosEmails(); // Revalida todos os campos de e-mail
	}
	
	
	function mostrarform (){
		document.getElementById("frmEmail").style.display = "block";
		document.getElementById("mostrarform").style.display = "none";
		document.getElementById('btnEnviar').disabled = true;
	}

	function ExibirEmail (html){
		// Expressão regular avançada para encontrar e-mails
		const emailRegex = /[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}/g;
		const emails = html.match(emailRegex);

		// Verifica se algum e-mail foi encontrado e os exibe
	if (emails) {
  		return emails.join(', ');
	} else {
  		return '';
	}
	}

	document.addEventListener('DOMContentLoaded', function () {
		const docHtml = `${doc.html}`; // Supõe-se que essa variável vem do servidor ou de alguma outra fonte
		const email = ExibirEmail(docHtml);
		const emailInput = document.getElementById('email');
		if (emailInput) {
			emailInput.value = email;
		}
	});
	
</script>

<siga:pagina titulo="Gerar Protocolo" popup="true">
	<style>
	   @media print { 
	       #btn-form { display:none; } 
	       #bg {-webkit-print-color-adjust: exact;}
		
	   }
	   #frmEmail{
		display:none;
	   }

	   .form-group {
		display: flex;
		flex-direction: column;
		}
	
		.form-group label {
		margin-bottom: 0.5rem;
		}
	
		.row .col-sm-10 {
		padding-right: 0;
		}
	
		.row .col-sm-2 {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		padding-left: 0;
		}
	
	</style>
	<!-- main content bootstrap -->
	<div class="card-body">
		<div class="row">	

			<div class="col-sm-12">
				<div class="text-center">
					<img src="${pageContext.request.contextPath}/imagens/${f:resource('/siga.relat.brasao')}" class="rounded float-left" width="100px"/>
					<h4><b>${f:resource('/siga.relat.titulo')}</b></h4>
					<h5>${doc.orgaoUsuario.descricao}</h5>
					<h5>${doc.lotacao.descricao }</h5>
				</div>
			</div>
		</div>
		<br>
		
		<div  style="font-size: 26px">
		<div class="row">
			<div class="col-sm-12">
				<div class="p-3 mb-2 bg-dark text-white text-center"  id="bg"><h4><b>Protocolo de Acompanhamento de Documento</b><h4></div>
			</div>
		</div>
		<br>
		<br>
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group text-center">
					<label>N&uacute;mero do Documento: <b>${sigla}</b></label>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group text-center">
					<!-- <label>N&uacute;mero do Protocolo: <b>${protocolo.numero} / ${ano}</b></label> -->
					<label>C&oacute;digo do Protocolo: <b>${protocolo.codigo}</b></label>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group text-center">
					<label>Data ${dataHora}</label>
				</div>
			</div>
		</div>
		<div class="row">
            <div class="col-sm-12">
                <div class="form-group text-center">
                    <label>Descri&ccedil;&atilde;o do Documento:<p><b>${doc.descrDocumento}</b></p> </label>
                </div>
            </div>
        </div>
		<br>
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group text-center">
					<label><b>Aten&ccedil;&atilde;o: </b>Para consultar o andamento do seu documento acesse</label>
					<br />
					<!--<a href="${url}" target="_blank">${url}</a>-->
					<a href="${sigaex.custom.url}" target="_blank">${sigaex.custom.url}</a>
					<br />
					<label>Ou Qrcode: <img src="${pageContext.request.contextPath}/GenerateQRCode?data=${url}" alt="QR Code" /></label>
					<br />
					<label>Ou acesse o Portal da Prefeitura, clique na op&ccedil;&atilde;o "Consulta de Protocolo SIGA" e preencha com o c&oacute;digo do Protocolo</label>
					<br />
					<a href="https://novoportal.riopreto.sp.gov.br/protocolos">https://novoportal.riopreto.sp.gov.br/protocolos</a>
				</div>
			</div>
		</div>
		</div>
		<br>
		<br>
		<br />
		<div id="btn-form">
			<form name="frm" action="principal" namespace="/" method="get"
				theme="simple">
				<button type="button" class="btn btn-primary" onclick="javascript: document.body.offsetHeight; window.print();" >Imprimir</button>
			</form>
			<br />
			<form id="frmEmail" action="${pageContext.request.contextPath}/app/expediente/mov/enviar_para_visualizacao_externa_protocolo?url=${url}&Descricao=${doc.descrDocumento}&codProtocolo=${protocolo.codigo}"
                  method="post" onsubmit="return validarPreenchimentoEmails()">
                <input type="hidden" name="sigla" value="${sigla}" />
				<div id="emailEntries"> <!-- Container para adicionar dinamicamente os e-mails -->
                	<div class="row">
                    	<div class="col-sm-12">
                        	<div class="form-group">
                           		<label for="nmPessoa">Nome: </label>
                            	<input type="text" id="nmPessoa" name="nmPessoa" value="${nmPessoa}" maxlength="60"
                                   class="form-control" oninput="verificarPreenchimentoTodosEmails()" onkeyup="validarNome(this)"/>
                        	</div>
                    	</div>
                	</div>
				</div>
                <div class="row">
                    <div class="col-sm-10">
                        <div class="form-group">
							<label for="email">E-mail:</label>
                            <input type="email" id="email" name="email" maxlength="60"
                                   onchange="validarEmail(this)" onkeyup="this.value = this.value.toLowerCase().trim()"
                                   class="form-control" oninput="verificarPreenchimentoTodosEmails()" />
                        </div>
                    </div>
                </div>
				<div class="row">
                    <div class="col">
                        <button type="button" onclick="AdicionarEmail()" class="btn btn-primary"><i class="fas fa-envelope"></i>
                            AddEmail
                        </button>
                    </div>
                </div>
				<br >
                <div class="row">
                    <div class="col">
                        <button type="submit" id="btnEnviar" class="btn btn-lg btn-primary btn-block"><i class="fas fa-envelope"></i>
                            Enviar
                        </button>
                    </div>
                </div>
            </form>
			<button type="button" class="btn btn-primary" onclick="mostrarform()" id="mostrarform"><i class="fas fa-envelope"></i>
				Enviar por Email
			</button>
		</div>	
	</div>
		
	
</siga:pagina>