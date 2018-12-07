
	/**
	 * 목록
	 */
	var jsList = function() {
		location.href = "BD_crud.list.do?" + jsSearchQueryString("dataForm");
	};

	/**
	 * 상세
	 */
	var jsView = function(seq) {
		$("#q_seq").val(seq);
		location.href = "BD_crud.view.do?" + jsSearchQueryString("dataForm");
	};

	/**
	 * 등록 폼
	 */
	var jsInsertForm = function() {
		$("#q_seq").val("");
		location.href = "BD_crud.insert.form.do?" + jsSearchQueryString("dataForm");	
	};

	/**
	 * 수정 폼
	 */
	var jsUpdateForm = function() {
		location.href = "BD_crud.update.form.do?" + jsSearchQueryString("dataForm");	
	};

	/**
	 * 삭제
	 */
	var jsDelete = function() {
		$("#dataForm").attr("action","ND_crud.delete.do");
		$("#dataForm").submit();
	};

	/**
	 * 목록 삭제
	 */
	var jsDeleteList = function() {
		$("#searchForm").attr("action","ND_crud.list.delete.do");
		$("#searchForm").submit();
	};

	/**
	 * 답변 등록 폼
	 */
	var jsReplyInsertForm = function() {
		location.href = "BD_crud.reply.insert.form.do?" + jsSearchQueryString("dataForm");	
	};

	/**
	 * 답변 수정 폼
	 */
	var jsReplyUpdateForm = function(replySeq) {
		$("#q_replySeq").val(replySeq);
		location.href = "BD_crud.reply.update.form.do?" + jsSearchQueryString("dataForm");	
	};

	/**
	 * 답변 삭제
	 */
	var jsReplyDelete = function(replySeq) {
		$("#q_replySeq").val(replySeq);
		$("#dataForm").attr("action","ND_crud.reply.delete.do");
		$("#dataForm").submit();
	};

