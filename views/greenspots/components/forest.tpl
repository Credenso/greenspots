% setdefault('trees', {'length': 1, 'data': {'127.0.0.1': ['2024-01-09']}, 'user': '127.0.0.1'})

<style>
	.tree {
		position: fixed;
		bottom: 0;
		transform: translateY(10%);
		z-index: -1;
	}

	.me {
		background-color: #FFFF0022;
		border-radius: 50%;
	}

	.spacer {
		height: 10em;
	}
</style>

<div onclick="visit()" class="spacer"></div>

% for tree in trees.get('data').items():
	<%
	import math
	if tree[0] == trees.get('user'):
		me = True
	else:
		me = False
	end

	ip = tree[0].split('.')
	height = 8 * math.log(len(tree[1])/2 + 1)
	tree_id = divmod(int(ip[3]), 22)[1]
	x_position = divmod((int(ip[0]) + int(ip[1]) + int(ip[2])), 100)[1] - 5
	%>
	<img 
	    % if me:
	    class="tree me" 
	    % else:
	    class="tree" 
	    % end
	    src="{{ static_path }}trees/tree-svgrepo-com({{ tree_id }}).svg" 
	    style="left: {{x_position}}vw; height: {{ height }}em" 
	/>
% end

<script>
	const visit = (site) => {
		window.location = "trees"
	}
</script>
