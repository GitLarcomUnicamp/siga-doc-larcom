
<%@ include file="/WEB-INF/page/include.jsp"%>

<c:if
			test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;PR:Procedimentos')}">
<li class="nav-item dropdown"><a href="javascript:void(0);"
	class="nav-link dropdown-toggle" data-toggle="dropdown">Procedimentos</a>
	<ul class="dropdown-menu">
		<c:if
			test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;PR;PES:Pesquisar')}">
		<li><a class="dropdown-item"
			href="${linkTo[WfAppController].pesquisar}">Pesquisar</a></li>
		</c:if>			
		<c:if
			test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;PR;INI:Iniciar')}">
			<li><a class="dropdown-item"
				href="${linkTo[WfAppController].listarParaIniciar}">Iniciar</a></li>
		</c:if>
		<c:if
			test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;PR;ATI:Ativos')}">		
		<li><a class="dropdown-item"
			href="${linkTo[WfAppController].ativos}">Ativos</a></li>
		</c:if>			
	</ul>
		</c:if>		
	 <c:if
		test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;FE:Ferramentas')}">
		<li class="nav-item dropdown"><a href="javascript:void(0);"
			class="nav-link dropdown-toggle" data-toggle="dropdown">Ferramentas</a>
			<ul class="dropdown-menu navmenu-large">
				<c:if
					test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;FE;DEFP:Cadastrar Diagramas')}">
					<li><a class="dropdown-item"
						href="${linkTo[WfDiagramaController].lista()}">Cadastro de
							Diagramas</a></li>
				</c:if>
				<c:if
					test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;FE;DEFR:Cadastrar Responsáveis')}">
					<li><a class="dropdown-item"
						href="${linkTo[WfResponsavelController].lista()}">Cadastro de
							Responsáveis</a></li>
				</c:if>
				<c:if
					test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;FE;CFG:Cadastrar Configurações')}">
					<li><a class="dropdown-item"
						href="${linkTo[WfConfiguracaoController].lista()}">Cadastro de
							Configurações</a></li>
				</c:if>
			</ul></li>
	</c:if></li>
<c:if
	test="${f:podeUtilizarServicoPorConfiguracao(titular,lotaTitular,'SIGA;WF;REL:Relatórios')}">
	<li class="nav-item dropdown"><a href="javascript:void(0);"
		class="nav-link dropdown-toggle" data-toggle="dropdown">Relatórios
	</a>
		<ul class="dropdown-menu navmenu-large">
			<li><a class="dropdown-item"
				href="${linkTo[WfRelatorioController].listarParaGerarRelatorios()}">Medições</a></li>
		</ul></li>
</c:if>