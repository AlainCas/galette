{if $is_form eq true}
<fieldset class="cssform">
	<legend>{_T("Additionnal informations:")}</legend>
{/if}
{foreach from=$dynamic_fields item=field}
{if $field.field_perm ne 1 || $smarty.session.admin_status eq 1}
	{if $field.field_type eq 0}
		{if $is_form eq false}
			<tr>
				<th class="separator">{$field.field_name|escape}&nbsp;</th>
			</tr>
		{else}
			<div class="separator">{$field.field_name|escape}</div>
		{/if}
	{else}
		{if $is_form eq false}
			<tr>
		{else}
			<p>
		{/if}
		{if $is_form eq false}
				<th>{$field.field_name|escape}&nbsp;</th>
		{else}
				<label class="bline libelle {if $field.field_required eq 1} required{/if}">{$field.field_name|escape}&nbsp;</label>
		{/if}
				{if $is_form eq false}<td>{/if}
		{section name="fieldLoop" start=1 loop=$field.field_repeat+1}
		{if $is_form eq false}
					{$data.dyn[$field.field_id][$smarty.section.fieldLoop.index]|nl2br|default:"&nbsp;"}
		{else}
			{if $field.field_type eq 1}
					<textarea name="info_field_{$field.field_id}_{$smarty.section.fieldLoop.index}"
					cols="{if $field.field_width > 0}{$field.field_width}{else}61{/if}"
					rows="{if $field.field_height > 0}{$field.field_height}{else}6{/if}"
					{$disabled.dyn[$field.field_id]}>{$data.dyn[$field.field_id][$smarty.section.fieldLoop.index]|escape}</textarea>
			{elseif $field.field_type eq 2}
					<input type="text" name="info_field_{$field.field_id}_{$smarty.section.fieldLoop.index}"
					{if $field.field_width > 0}size="{$field.field_width}"{/if}
					{if $field.field_size > 0}maxlength="{$field.field_size}"{/if}
					value="{$data.dyn[$field.field_id][$smarty.section.fieldLoop.index]|escape}" size="63" {$disabled.dyn[$field.field_id]}/>
			{elseif $field.field_type eq 3}
					<select name="info_field_{$field.field_id}_{$smarty.section.fieldLoop.index}">
						{html_options options=$field.choices selected=$data.dyn[$field.field_id][$smarty.section.fieldLoop.index]}
					</select>
			{/if}
		{/if}
		{/section}
		{if $is_form eq false}
				</td>
			</tr>
		{else}
			</p>
		{/if}
	{/if}
{/if}
{/foreach}
{if $is_form eq true}
	</fieldset>
{/if}
