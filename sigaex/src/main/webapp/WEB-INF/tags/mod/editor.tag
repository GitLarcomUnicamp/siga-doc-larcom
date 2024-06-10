<%@tag import="com.ckeditor.CKEditorInsertTag"%>
<%@tag import="com.ckeditor.CKEditorTag"%>
<%@tag import="com.ckeditor.CKEditorConfig"%>
<%@ tag body-content="empty"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/functiontag" prefix="f"%>
<%@ taglib uri="http://ckeditor.com" prefix="FCK"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ attribute name="titulo"%>
<%@ attribute name="var"%>
<%@ attribute name="entrevista"%>
<%@ attribute name="modeloPrenchido"%>
<%@ attribute name="nmArqMod"%>
<%@ attribute name="conteudo"%>
<%@ attribute name="semBotaoSalvar"%>


<c:set var="v" value="${param[var]}" />
<c:if test="${empty v}">
	<c:set var="v" value="${requestScope[var]}" />
</c:if>
<c:if test="${empty v}">
	<c:set var="v" value="${conteudo}" />
</c:if>

<input type="hidden" name="vars" value="${var}" />
<input type="hidden" id="desconsiderarExtensao" name="desconsiderarExtensao" value="${par.desconsiderarExtensao[0]}" />

<div><c:if test="${not empty titulo}">
	<b>${titulo}</b>
</c:if> <c:choose>
	<c:when test="${param.entrevista == 1}">
	
		<c:if test="${empty v}">
							<c:set var="v" value='<p style="TEXT-INDENT: 2cm" align="justify">&nbsp;</p>'/>
					</c:if>
	
		<%
			String s = (String) jspContext.getAttribute("v");
					jspContext.setAttribute("v",
							br.gov.jfrj.siga.ex.bl.Ex.getInstance().getBL().canonicalizarHtml(s, false, true, false,
											true));
					String var1 = (String) jspContext.getAttribute("var");
					request.setAttribute(var1, jspContext.getAttribute("v"));
		%>

		<div><c:choose>
			<c:when test="${f:podeUtilizarExtensaoEditor(lotaTitular, idMod) && !par.desconsiderarExtensao[0]}">
				<input type="hidden" id="${var}" name="${var}" value="<c:out value="${v}" escapeXml="true" />" >
				${f:obterExtensaoEditor(lotaTitular.orgaoUsuario, var, v, par.serverAndPort[0])}
			</c:when>
			<c:otherwise>
			<tags:fixeditor var="${var}">
					<c:if test="${empty v}">
							<c:set var="v" value='<p style="TEXT-INDENT: 2cm" align="justify"></p>'/>
					</c:if>
					<textarea cols="100" id="xxxeditorxxx" name="xxxeditorxxx" rows="20" class="editor">${v}</textarea>
					
					
					 	<script type="text/javascript">

								
						//CKEDITOR.config.autoGrow_onStartup = true;
						//CKEDITOR.config.autoGrow_bottomSpace = 50;
						//CKEDITOR.config.autoGrow_maxHeight = 400;
						CKEDITOR.config.removePlugins = 'elementspath';
						CKEDITOR.config.image_previewText = ' ';
						CKEDITOR.config.height = 270;
						CKEDITOR.config.filebrowserUploadMethod = 'form';
						//CKEDITOR.config.removeButtons = 'Image';
						CKEDITOR.config.removeDialogTabs = 'link:advanced;link:upload;image:advanced;image:Link';
						CKEDITOR
						.replace(
						'conteudo',
						{
							filebrowserUploadUrl : '${linkTo[AppController].gravarArquivo}?origem=editar'
									+ '&informacao.id=' + '${informacao.id}',
							toolbar : [
									{
										name : 'clipboard',
										groups : [ 'clipboard', 'undo' ],
										items : [ 'Cut', 'Copy', 'Paste',
												'PasteText', 'PasteFromWord',
												'-', 'Undo', 'Redo' ]
									},
									{
										name : 'editing',
										groups : [ 'find', 'selection' ],
										items : [ 'Find', 'Replace', '-',
												'SelectAll' ]
									},
									{
										name : 'links',
										items : [ 'Link', 'Unlink', 'Anchor' ]
									},
									{
										name : 'document',
										groups : [ 'mode', 'document',
												'doctools' ],
										items : [ 'Maximize', '-', 'Source' ]
									},
									{
										name : 'basicstyles',
										groups : [ 'basicstyles', 'cleanup' ],
										items : [ 'Bold', 'Italic',
												'Underline', 'Strike',
												'Subscript', 'Superscript',
												'-', 'RemoveFormat' ]
									},
									{
										name : 'paragraph',
										groups : [ 'list', 'indent', 'blocks',
												'align', 'bidi' ],
										items : [ 'NumberedList',
												'BulletedList', '-', 'Outdent',
												'Indent', '-', 'Blockquote',
												'-', 'JustifyLeft',
												'JustifyCenter',
												'JustifyRight', 'JustifyBlock' ]
									},
									{
										name : 'insert',
										items : [ 'Image', 'Table', 'Smiley',
												'SpecialChar' ]
									}, {
										name : 'styles',
										items : [ 'Styles', 'Format' ]
									}, {
										name : 'colors',
										items : [ 'TextColor', 'BGColor' ]
									} ]

						});
						//$(".cke_botom").hide();

                        </script>
                            
                            
					<!-- <FCK:replace replace="xxxeditorxxx" basePath="/ckeditor/ckeditor" config="${ckconfig}"></FCK:replace> -->
					</td>
				</tags:fixeditor>
			</c:otherwise>
		</c:choose></div>
	</c:when>
	<c:otherwise>
		<br>
		${v}
		<br>
		<br>
	</c:otherwise>
</c:choose></div>



