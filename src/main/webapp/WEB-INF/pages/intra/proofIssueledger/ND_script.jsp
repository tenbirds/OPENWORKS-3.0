<script>
	parent.location.reload();
	if($.fn.colorbox) {
		if(parent)
			parent.$.fn.colorbox.close();
	} else {
		self.close();
	}
</script>