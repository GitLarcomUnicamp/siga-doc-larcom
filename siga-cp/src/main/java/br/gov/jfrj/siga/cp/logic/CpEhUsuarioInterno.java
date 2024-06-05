package br.gov.jfrj.siga.cp.logic;

import com.crivano.jlogic.Expression;
import com.crivano.jlogic.JLogic;

import br.gov.jfrj.siga.dp.DpPessoa;

public class CpEhUsuarioInterno implements Expression {

	private DpPessoa titular;

	public CpEhUsuarioInterno(DpPessoa titular) {
		this.titular = titular;

	}

	@Override
	public boolean eval() {
		return ! (titular != null && titular.isUsuarioExterno());
	}

	@Override
	public String explain(boolean result) {
		 return JLogic.NOT + " é Usuário Interno";
	}
};