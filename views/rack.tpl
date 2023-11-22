% rebase('base.tpl', title='Bottle Rack')
% setdefault('potions', [])
<h2>Available Potions</h2>
% if len(potions) == 0:
<p>No potions available! Have you prepared any yet?</p>
% else:
<section class="menu">
% for potion in potions:
        <article class="box" onclick="location.pathname = '{{ potion['path'] }}'" >
            <h4>{{ potion['name'] }}</h4>
            <p>{{ potion['description'] }}</p>
        </article>
% end
</section>
% end
