{if $navigate|@count != 0}
    <nav>
        <a id="prev" href="{if $navigate.prev}?id_adh={$navigate.prev}{else}#{/if}" class="button{if !$navigate.prev} selected{/if}">{_T string="Previous"}</a>
        {$navigate.pos}/{$navigate.count}
        <a id="next" href="{if $navigate.next}?id_adh={$navigate.next}{else}#{/if}"class="button{if !$navigate.next} selected{/if}">{_T string="Next"}</a>
    </nav>
{/if}
		<ul id="details_menu">
{if ($pref_card_self eq 1) or ($login->isAdmin() or $login->isStaff())}
			<li>
				<a class="button" href="carte_adherent.php?id_adh={$member->id}" id="btn_membercard">{_T string="Generate Member Card"}</a>
			</li>
    {if $pref_mail_method neq constant('Galette\Core\GaletteMail::METHOD_DISABLED')}
            <li>
				<a class="button" href="lostpasswd.php?id_adh={$member->id}" id="btn_lostpassword" title="{_T string="Send member a link to generate a new passord, as if had used the 'lost password' functionnality."}">{_T string="New password"}</a>
            </li>
    {/if}
{/if}
			<li>
				<a class="button" href="ajouter_adherent.php?id_adh={$member->id}" id="btn_edit">{_T string="Modification"}</a>
			</li>
{if $login->isAdmin() or $login->isStaff()}
			<li>
				<a class="button" href="gestion_contributions.php?id_adh={$member->id}" id="btn_contrib">{_T string="View contributions"}</a>
			</li>
			<li>
				<a class="button" href="ajouter_contribution.php?id_adh={$member->id}" id="btn_addcontrib">{_T string="Add a contribution"}</a>
			</li>
{/if}
{* If some additionnals actions should be added from plugins, we load the relevant template file
We have to use a template file, so Smarty will do its work (like replacing variables). *}
{if $plugin_detailled_actions|@count != 0}
  {foreach from=$plugin_detailled_actions item=action}
    {include file=$action}
  {/foreach}
{/if}

		</ul>
	<div class="bigtable wrmenu">

		<table class="details">
			<caption class="ui-state-active ui-corner-top">{_T string="Identity:"}</caption>
			<tr>
				<th>{_T string="Name:"}</th>
				<td>{$member->spoliteness} {$member->name} {$member->surname}</td>
				<td rowspan="{if $member->isCompany()}7{else}6{/if}" style="width:{$member->picture->getOptimalWidth()}px;">
                    <img
                        src="{$galette_base_path}picture.php?id_adh={$member->id}&amp;rand={$time}"
                        width="{$member->picture->getOptimalWidth()}"
                        height="{$member->picture->getOptimalHeight()}"
                        alt="{_T string="Picture"}"
                        id="photo_adh"/>
                </td>
			</tr>
{if $member->isCompany()}
            <tr>
                <th>{_T string="Company:"}</th>
                <td>{$member->company_name}</td>
            </tr>
{/if}
			<tr>
				<th>{_T string="Nickname:"}</th>
				<td>{$member->nickname|htmlspecialchars}</td>
			</tr>
			<tr>
				<th>{_T string="Birth date:"}</th>
				<td>{$member->birthdate}</td>
			</tr>
			<tr>
				<th>{_T string="Birthplace:"}</th>
				<td>{$member->birth_place}</td>
			</tr>
			<tr>
				<th>{_T string="Profession:"}</th>
				<td>{$member->job|htmlspecialchars}</td>
			</tr>
			<tr>
				<th>{_T string="Language:"}</th>
				<td><img src="{$pref_lang_img}" alt=""/> {$pref_lang}</td>
			</tr>
		</table>

		<table class="details">
			<caption class="ui-state-active ui-corner-top">{_T string="Contact information:"}</caption>
			<tr>
				<th>{_T string="Address:"}</th>
				<td>
					{$member->adress|htmlspecialchars}
{if $member->adress_continuation ne ''}
					<br/>{$member->adress_continuation|htmlspecialchars}
{/if}
				</td>
			</tr>
			<tr>
				<th>{_T string="Zip Code:"}</th>
				<td>{$member->zipcode}</td>
			</tr>
			<tr>
				<th>{_T string="City:"}</th>
				<td>{$member->town|htmlspecialchars}</td>
			</tr>
			<tr>
				<th>{_T string="Country:"}</th>
				<td>{$member->country|htmlspecialchars}</td>
			</tr>
			<tr>
				<th>{_T string="Phone:"}</th>
				<td>{$member->phone}</td>
			</tr>
			<tr>
				<th>{_T string="Mobile phone:"}</th>
				<td>{$member->gsm}</td>
			</tr>
			<tr>
				<th>{_T string="E-Mail:"}</th>
				<td>
{if $member->email ne ''}
					<a href="mailto:{$member->email}">{$member->email}</a>
{/if}
				</td>
			</tr>
			<tr>
				<th>{_T string="Website:"}</th>
				<td>
{if $member->website ne ''}
					<a href="{$member->website}">{$member->website}</a>
{/if}
				</td>
			</tr>
			<tr>
				<th>{_T string="ICQ:"}</th>
				<td>{$member->icq}</td>
			</tr>
			<tr>
				<th>{_T string="Jabber:"}</th>
				<td>{$member->jabber}</td>
			</tr>
			<tr>
				<th>{_T string="MSN:"}</th>
				<td>
{if $member->msn ne ''}
					<a href="mailto:{$member->msn}">{$member->msn}</a>
{/if}
				</td>
			</tr>
			<tr>
				<th>{_T string="Id GNUpg (GPG):"}</th>
				<td>{$member->gpgid}</td>
			</tr>
			<tr>
				<th>{_T string="fingerprint:"}</th>
				<td>{$member->fingerprint}</td>
			</tr>
		</table>

		<table class="details">
			<caption class="ui-state-active ui-corner-top">{_T string="Galette-related data:"}</caption>
			<tr>
				<th>{_T string="Be visible in the<br /> members list :"}</th>
				<td>{$member->sappears_in_list}</td>
			</tr>
{if $login->isAdmin() or $login->isStaff()}
			<tr>
				<th>{_T string="Account:"}</th>
				<td>{$member->sactive}</td>
			</tr>
{/if}
			<tr>
				<th>{_T string="Status:"}</th>
				<td>{$member->sstatus}</td>
			</tr>
{if $login->isAdmin() or $login->isStaff()}
			<tr>
				<th>{_T string="Galette Admin:"}</th>
				<td>{$member->sadmin}</td>
			</tr>
			<tr>
				<th>{_T string="Freed of dues:"}</th>
				<td>{$member->sdue_free}</td>
			</tr>
{/if}
			<tr>
				<th>{_T string="Username:"}</th>
				<td>{$member->login}</td>
			</tr>
{if $login->isAdmin() or $login->isStaff()}
			<tr>
				<th>{_T string="Creation date:"}</th>
				<td>{$member->creation_date}</td>
			</tr>
			<tr>
				<th>{_T string="Last modification date:"}</th>
				<td>{$member->modification_date}</td>
			</tr>
			<tr>
				<th>{_T string="Other informations (admin):"}</th>
				<td>{$member->others_infos_admin|htmlspecialchars|nl2br}</td>
			</tr>
{/if}
			<tr>
				<th>{_T string="Other informations:"}</th>
				<td>{$member->others_infos|htmlspecialchars|nl2br}</td>
			</tr>
{if $member->groups != false && $member->groups|@count != 0}
			<tr>
				<th>{_T string="Groups:"}</th>
				<td>
    {foreach from=$groups item=group key=kgroup}
        {if $member->isGroupMember($group) or $member->isGroupManager($group)}
                    <a href="{if $login->isGroupManager($kgroup)}gestion_groupes.php?id_group={$kgroup}{else}#{/if}" class="button group-btn{if not $login->isGroupManager($kgroup)} notmanaged{/if}">
                        {$group}
            {if $member->isGroupMember($group)}
                        <img src="{$template_subdir}images/icon-user.png" alt="{_T string="[member]"}" width="16" height="16"/>
            {/if}
            {if $member->isGroupManager($group)}
                        <img src="{$template_subdir}images/icon-star.png" alt="{_T string="[manager]"}" width="16" height="16"/>
            {/if}
                    </a>
        {/if}
    {/foreach}
				</td>
			</tr>
{/if}
		</table>

{include file="display_dynamic_fields.tpl" is_form=false}
	</div>
{if $login->isAdmin() or $login->isStaff() or $login->login eq $member->login}
    <script type="text/javascript">
        $(function() {ldelim}
            {include file="photo_dnd.tpl"}

            $('.notmanaged').click(function(){ldelim}
                var _el = $('<div id="not_managed_group" title="{_T string="Not managed group" escape="js"}">{_T string="You are not part of managers for the requested group." escape="js"}</div>');
                _el.appendTo('body').dialog({ldelim}
                    modal: true,
                    buttons: {ldelim}
                        "{_T string="Ok" escape="js"}": function() {ldelim}
                            $( this ).dialog( "close" );
                        {rdelim}
                    {rdelim},
                    close: function(event, ui){ldelim}
                        _el.remove();
                    {rdelim}
                {rdelim});
                return false;
            {rdelim});
        {rdelim});
    </script>
{/if}