package br.gov.jfrj.siga.vraptor;

import java.util.Date;

public class ExMobilDTO{
    private String dnmSigla;
    private Long idMobil;
    private String descricao;
    private Date dtAlt;

    public ExMobilDTO() {
    }

    public String getDnmSigla() {
        return dnmSigla;
    }

    public void setDnmSigla(String dnmSigla) {
        this.dnmSigla = dnmSigla;
    }

    public Long getIdMobil() {
        return idMobil;
    }

    public void setIdMobil(Long idMobil) {
        this.idMobil = idMobil;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }


    public Date getDtAlt() {
        return dtAlt;
    }


    public void setDtAlt(Date dtAlt) {
        this.dtAlt = dtAlt;
    }

}
