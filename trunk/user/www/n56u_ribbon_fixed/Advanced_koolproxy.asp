<!DOCTYPE html>
<html>
<head>
<title><#Web_Title#> - koolproxy</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<link rel="shortcut icon" href="images/favicon.ico">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
<link rel="stylesheet" type="text/css" href="/bootstrap/css/engage.itoggle.css">

<script type="text/javascript" src="/jquery.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/engage.itoggle.min.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/itoggle.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {
	init_itoggle('koolproxy_enable',change_koolproxy_enable);
	init_itoggle('koolproxy_cpu');
	init_itoggle('hosts_ad');
	init_itoggle('tv_hosts');
	init_itoggle('koolproxy_https');
	init_itoggle('koolproxy_video');
	init_itoggle('koolproxy_prot');
	init_itoggle('rules_list',change_rules_list);
	init_itoggle('ss_DNS_Redirect',change_ss_DNS_Redirect);
});

</script>
<script>
<% koolproxy_status(); %>
<% login_state_hook(); %>

function initial(){
	show_banner(2);
	show_menu(5,15,2);
	show_footer();
	fill_koolproxy_status(koolproxy_status());
	change_koolproxy_enable();
	change_rules_list();
	change_ss_DNS_Redirect();
	if (!login_safe())
		textarea_scripts_enabled(0);
}

function textarea_scripts_enabled(v){
	inputCtrl(document.form['scripts.koolproxy_rules_list.sh'], v);
	inputCtrl(document.form['scripts.koolproxy_rules_script.sh'], v);
	inputCtrl(document.form['scripts.ad_config_script.sh'], v);
}

function applyRule(){
//	if(validForm()){
		showLoading();
		
		document.form.action_mode.value = " Apply ";
		document.form.current_page.value = "/Advanced_koolproxy.asp";
		document.form.next_page.value = "";
		
		document.form.submit();
//	}
}

function submitInternet(v){
	showLoading();
	document.koolproxy_action.action = "Kp_action.asp";
	document.koolproxy_action.connect_action.value = v;
	document.koolproxy_action.submit();
}

function change_koolproxy_enable(){
	var m = document.form.koolproxy_enable[0].checked;
	showhide_div('kp_update_b', m);
}

function change_rules_list(){
if(document.form.rules_list_3.checked==true){
	var m = document.form.rules_list_3.checked;
	showhide_div('koolproxy_txt', m);
	showhide_div('daily_txt', m);
	showhide_div('kp_dat', m);
	}else{
	showhide_div('koolproxy_txt', false);
	showhide_div('daily_txt', false);
	showhide_div('kp_dat', false);
}
}
function fill_koolproxy_status(status_code){
	var stext = "Unknown";
	if (status_code == 0)
		stext = "<#Stopped#>";
	else if (status_code == 1)
		stext = "<#Running#>";
	$("koolproxy_status").innerHTML = '<span class="label label-' + (status_code != 0 ? 'success' : 'warning') + '">' + stext + '</span>';
}
function change_ss_DNS_Redirect(){
	var m = document.form.ss_DNS_Redirect[0].checked;
	var is_ss_DNS_Redirect = (m == "1") ? 1 : 0;
	showhide_div("ss_DNS_Redirect_IP_tr", is_ss_DNS_Redirect);
}

function button_updatead(){
	var $j = jQuery.noConflict();
	$j.post('/apply.cgi',
	{
		'action_mode': ' updatekp ',
	});
}

</script>
</head>

<body onload="initial();" onunLoad="return unload_body();">

<div class="wrapper">
	<div class="container-fluid" style="padding-right: 0px">
		<div class="row-fluid">
			<div class="span3"><center><div id="logo"></div></center></div>
			<div class="span9" >
				<div id="TopBanner"></div>
			</div>
		</div>
	</div>

	<div id="Loading" class="popup_bg"></div>

	<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>

	<form method="post" name="form" id="ruleForm" action="/start_apply.htm" target="hidden_frame">

	<input type="hidden" name="current_page" value="Advanced_koolproxy.asp">
	<input type="hidden" name="next_page" value="">
	<input type="hidden" name="next_host" value="">
	<input type="hidden" name="sid_list" value="KoolproxyConf;LANHostConfig;General;">
	<input type="hidden" name="group_id" value="">
	<input type="hidden" name="action_mode" value="">
	<input type="hidden" name="action_script" value="">
	<input type="hidden" name="wan_ipaddr" value="<% nvram_get_x("", "wan0_ipaddr"); %>" readonly="1">
	<input type="hidden" name="wan_netmask" value="<% nvram_get_x("", "wan0_netmask"); %>" readonly="1">
	<input type="hidden" name="dhcp_start" value="<% nvram_get_x("", "dhcp_start"); %>">
	<input type="hidden" name="dhcp_end" value="<% nvram_get_x("", "dhcp_end"); %>">

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3">
				<!--Sidebar content-->
				<!--=====Beginning of Main Menu=====-->
				<div class="well sidebar-nav side_nav" style="padding: 0px;">
					<ul id="mainMenu" class="clearfix"></ul>
					<ul class="clearfix">
						<li>
							<div id="subMenu" class="accordion"></div>
						</li>
					</ul>
				</div>
			</div>

			<div class="span9">
				<!--Body content-->
				<div class="row-fluid">
					<div class="span12">
						<div class="box well grad_colour_dark_blue">
							<h2 class="box_head round_top"><#menu5_20#> - koolproxy</h2>
							<div class="round_bottom">
								<div class="row-fluid">
									<div id="tabMenu" class="submenuBlock"></div>
									<div class="alert alert-info" style="margin: 10px;">koolproxy - ???????????????<a href="http://koolshare.cn/thread-64086-1-1.html" target="blank">????????????: http://koolshare.cn/thread-64086-1-1.html</a> <a href="https://t.me/joinchat/AAAAAD-tO7GPvfOU131_vg" target="blank">Telegram</a>
									<div>????????????????????????????????????????????????????????????????????????????????????????????????https!</div>
									<div>koolproxy??????????????????<% nvram_get_x("", "koolproxy_rules_date_local"); %>??? / ???<% nvram_get_x("", "koolproxy_rules_nu_local"); %>?????? </div>
									<div>koolproxy??????????????????<% nvram_get_x("", "koolproxy_video_date_local"); %>??? </div>
									</div>
									<table width="100%" align="center" cellpadding="4" cellspacing="0" class="table">
											<tr> <th width="30%" style="border-top: 0 none;">????????????:</th>
                                            <td id="koolproxy_status" colspan="3"></td>
                                        </tr>
										<tr >
											<th width="30%" style="border-top: 0 none;">?????? koolproxy ?????? &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input id="kp_update_b" class="btn btn-success" style="width:110px display:none;" type="button" name="updatefrp" value="????????????" onclick="submitInternet('resetkp');" /></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="koolproxy_enable_on_of">
														<input type="checkbox" id="koolproxy_enable_fake" <% nvram_match_x("", "koolproxy_enable", "1", "value=1 checked"); %><% nvram_match_x("", "koolproxy_enable", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="koolproxy_enable" id="koolproxy_enable_1" class="input" onClick="change_koolproxy_enable();" <% nvram_match_x("", "koolproxy_enable", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="koolproxy_enable" id="koolproxy_enable_0" class="input" onClick="change_koolproxy_enable();" <% nvram_match_x("", "koolproxy_enable", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr >
											<th width="30%" style="border-top: 0 none;">?????? https ???????????? &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input type="button" onClick="location.href='kp_ca.crt'" value="<#CTL_onlysave#>??????" class="btn btn-success" style="width: 90px"></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="koolproxy_https_on_of">
														<input type="checkbox" id="koolproxy_https_fake" <% nvram_match_x("", "koolproxy_https", "1", "value=1 checked"); %><% nvram_match_x("", "koolproxy_https", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="koolproxy_https" id="koolproxy_https_1" class="input" <% nvram_match_x("", "koolproxy_https", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="koolproxy_https" id="koolproxy_https_0" class="input" <% nvram_match_x("", "koolproxy_https", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="50%">??????????????????</th>
											<td style="border-top: 0 none;">
												<select name="koolproxy_set" class="input">
													<option value="0" <% nvram_match_x("","koolproxy_set", "0","selected"); %>>??????????????????????????????????????????IP???koolproxy??????</option>
													<option value="1" <% nvram_match_x("","koolproxy_set", "1","selected"); %>>?????????koolproxylist???????????????????????????IP???koolproxy</option>
												</select>
												<div><span style="color:#888;">????????????ipset????????????????????????????????????</span></div>
												<div><span style="color:#888;">???????????????CPU????????????????????????</span></div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">??????????????????????????????</th>
											<td>
													<div class="main_itoggle">
													<div id="koolproxy_video_on_of">
														<input type="checkbox" id="koolproxy_video_fake" <% nvram_match_x("", "koolproxy_video", "1", "value=1 checked"); %><% nvram_match_x("", "koolproxy_video", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="koolproxy_video" id="koolproxy_video_1" class="input" value="1" <% nvram_match_x("", "koolproxy_video", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="koolproxy_video" id="koolproxy_video_0" class="input" value="0" <% nvram_match_x("", "koolproxy_video", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip" href="javascript: void(0)" onmouseover="openTooltip(this, 26, 1);">?????? CPU ?????????????????????????????? koolproxy ??????</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="koolproxy_cpu_on_of">
														<input type="checkbox" id="koolproxy_cpu_fake" <% nvram_match_x("", "koolproxy_cpu", "1", "value=1 checked"); %><% nvram_match_x("", "koolproxy_cpu", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="koolproxy_cpu" id="koolproxy_cpu_1" class="input" value="1" <% nvram_match_x("", "koolproxy_cpu", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="koolproxy_cpu" id="koolproxy_cpu_0" class="input" value="0" <% nvram_match_x("", "koolproxy_cpu", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">????????????????????????????????????</th>
											<td>
													<div class="main_itoggle">
													<div id="koolproxy_prot_on_of">
														<input type="checkbox" id="koolproxy_prot_fake" <% nvram_match_x("", "koolproxy_prot", "1", "value=1 checked"); %><% nvram_match_x("", "koolproxy_prot", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="koolproxy_prot" id="koolproxy_prot_1" class="input" value="1" <% nvram_match_x("", "koolproxy_prot", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="koolproxy_prot" id="koolproxy_prot_0" class="input" value="0" <% nvram_match_x("", "koolproxy_prot", "0", "checked"); %> /><#checkbox_No#>
												</div>
												<div><span style="color:#FF0000;">????????????????????????????????????80??????</span></div>
											</td>
										</tr>
										<tr id="ss_DNS_Redirect_tr" >
											<th width="30%" style="border-top: 0 none;"><a class="help_tooltip"  href="javascript:void(0);" onmouseover="openTooltip(this, 25,15);">????????? DNS (koolproxylist ??????????????????)</a></th>
											<td style="border-top: 0 none;">
													<div class="main_itoggle">
													<div id="ss_DNS_Redirect_on_of">
														<input type="checkbox" id="ss_DNS_Redirect_fake" <% nvram_match_x("", "ss_DNS_Redirect", "1", "value=1 checked"); %><% nvram_match_x("", "ss_DNS_Redirect", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="ss_DNS_Redirect" id="ss_DNS_Redirect_1" class="input" value="1" onclick="change_ss_DNS_Redirect();" <% nvram_match_x("", "ss_DNS_Redirect", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="ss_DNS_Redirect" id="ss_DNS_Redirect_0" class="input" value="0" onclick="change_ss_DNS_Redirect();" <% nvram_match_x("", "ss_DNS_Redirect", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="ss_DNS_Redirect_IP_tr" style="display:none;">
											<th style="border-top: 0 none;">DNS ???????????????:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="15"  class="none" size="60" name="ss_DNS_Redirect_IP" placeholder="<% nvram_get_x("", "lan_ipaddr"); %>" value="<% nvram_get_x("","ss_DNS_Redirect_IP"); %>" onKeyPress="return is_ipaddr(this,event);"/>
												<div>&nbsp;<span style="color:#888;">[??????]????????????IP</span></div>
											</td>
										</tr>
										<tr id="koolproxy_update_tr">
											<th style="border-top: 0 none;">??????????????????:</th>
											<td style="border-top: 0 none;">
												<select name="koolproxy_update" class="input" style="width: 60px;">
													<option value="0" <% nvram_match_x("","koolproxy_update", "0","selected"); %>>??????</option>
													<option value="1" <% nvram_match_x("","koolproxy_update", "1","selected"); %>>??????</option>
													<option value="2" <% nvram_match_x("","koolproxy_update", "2","selected"); %>>??????</option>
												</select>
												<input style="width: 20px;" type="text" maxlength="2"  class="none" size="60" name="koolproxy_update_hour" placeholder="23" value="<% nvram_get_x("","koolproxy_update_hour"); %>" onKeyPress="return is_number(this,event);"/>??????<input style="width: 20px;" type="text" maxlength="2"  class="none" size="60" name="koolproxy_update_min" placeholder="59" value="<% nvram_get_x("","koolproxy_update_min"); %>" onKeyPress="return is_number(this,event);"/>????????????
												&nbsp;<span style="color:#888;"></span>
												<div>&nbsp;<span style="color:#888;">????????????????????????????????????????????????</span></div>
											</td>
										</tr>
										<tr>
											<th width="30%" style="border-top: 0 none;">??????hosts???AD???</th>
											<td>
													<div class="main_itoggle">
													<div id="hosts_ad_on_of">
														<input type="checkbox" id="hosts_ad_fake" <% nvram_match_x("", "hosts_ad", "1", "value=1 checked"); %><% nvram_match_x("", "hosts_ad", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="hosts_ad" id="hosts_ad_1" class="input" value="1" <% nvram_match_x("", "hosts_ad", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="hosts_ad" id="hosts_ad_0" class="input" value="0" <% nvram_match_x("", "hosts_ad", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
																				<tr>
											<th width="30%" style="border-top: 0 none;">??????TVbox Hosts???</th>
											<td>
													<div class="main_itoggle">
													<div id="tv_hosts_on_of">
														<input type="checkbox" id="tv_hosts_fake" <% nvram_match_x("", "tv_hosts", "1", "value=1 checked"); %><% nvram_match_x("", "tv_hosts", "0", "value=0"); %>  />
													</div>
												</div>
												<div style="position: absolute; margin-left: -10000px;">
													<input type="radio" value="1" name="tv_hosts" id="tv_hosts_1" class="input" value="1" <% nvram_match_x("", "tv_hosts", "1", "checked"); %> /><#checkbox_Yes#>
													<input type="radio" value="0" name="tv_hosts" id="tv_hosts_0" class="input" value="0" <% nvram_match_x("", "tv_hosts", "0", "checked"); %> /><#checkbox_No#>
												</div>
											</td>
										</tr>
										<tr id="row_ad_dir" >
                                            <th width="50%">
                                                ????????????:
                                            </th>
                                            <td>
											<label class="radio inline">
                                                    <input type="radio" name="rules_list" id="rules_list_1" value="0" onclick="change_rules_list();" <% nvram_match_x("", "rules_list", "0", "checked"); %>/>??????
													</label>
                                         <label class="radio inline">
                                                    <input type="radio" name="rules_list" id="rules_list_2" value="1" onclick="change_rules_list();" <% nvram_match_x("", "rules_list", "1", "checked"); %>/>??????
													</label>
													<label class="radio inline">
                                                    <input type="radio" name="rules_list" id="rules_list_3" value="2" onclick="change_rules_list();" <% nvram_match_x("", "rules_list", "2", "checked"); %>/>?????????
													</label>
                                            </td>
                                        </tr>
										<tr id="koolproxy_txt" style="display:none;">
											<th style="border-top: 0 none;">koolproxy.txt????????????:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="255"  class="none" size="100" name="koolproxy_txt_2" value="<% nvram_get_x("","koolproxy_txt_2"); %>"/>

											</td>
											</tr>
											<tr id="daily_txt" style="display:none;">
											<th style="border-top: 0 none;">daily.txt????????????:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="255"  class="none" size="100" name="daily_txt_2" value="<% nvram_get_x("","daily_txt_2"); %>"/>

											</td>
											</tr>
											<tr id="kp_dat" style="display:none;">
											<th style="border-top: 0 none;">kp.dat????????????:</th>
											<td style="border-top: 0 none;">
												<input type="text" maxlength="255"  class="none" size="100" name="kp_dat_2" value="<% nvram_get_x("","kp_dat_2"); %>"/>

											</td>
											
										</tr>
										<tr>
											<td colspan="3" >
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script9')"><span>koolproxy??????????????????:</span></a>
												<div id="script9">
													<textarea rows="8" wrap="off" spellcheck="false" maxlength="314571" class="span12" name="scripts.koolproxy_rules_list.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.koolproxy_rules_list.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script10')"><span>koolproxy ?????????????????????:</span></a>
												<div id="script10" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="314571" class="span12" name="scripts.koolproxy_rules_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.koolproxy_rules_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr id="ad_config">
											<td colspan="3" style="border-top: 0 none;">
												<i class="icon-hand-right"></i> <a href="javascript:spoiler_toggle('script11')"><span>???????????????????????? IP ?????????????????????????????????????????????????????????</span></a>
												<div id="script11" style="display:none;">
													<textarea rows="24" wrap="off" spellcheck="false" maxlength="314571" class="span12" name="scripts.ad_config_script.sh" style="font-family:'Courier New'; font-size:12px;"><% nvram_dump("scripts.ad_config_script.sh",""); %></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2" style="border-top: 0 none;">
												<br />
												<center><input class="btn btn-primary" style="width: 219px" type="button" value="<#CTL_apply#>" onclick="applyRule()" /></center>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	</form>

	<div id="footer"></div>
</div>
<form method="post" name="koolproxy_action" action="">
    <input type="hidden" name="connect_action" value="">
</form>
</body>
</html>

