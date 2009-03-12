package gui_window::cod_out::csv;
use base qw(gui_window::cod_out);

use strict;

sub _save{
	my $self = shift;
	
	unless (-e $self->cfile){
		my $win = $self->win_obj;
		gui_errormsg->open(
			msg => "�����ǥ��󥰡��롼�롦�ե����뤬���򤵤�Ƥ��ޤ���",
			window => \$win,
			type => 'msg',
		);
		return;
	}
	
	# ��¸��λ���
	my @types = (
		[ "csv file",[qw/.csv/] ],
		["All files",'*']
	);
	my $path = $self->win_obj->getSaveFile(
		-defaultextension => '.csv',
		-filetypes        => \@types,
		-title            =>
			$self->gui_jt('�����ǥ��󥰷�̡�CSV�ˡ�̾�����դ�����¸'),
		-initialdir       => $self->gui_jchar($::config_obj->cwd)
	);
	
	# ��¸��¹�
	if ($path){
		$path = gui_window->gui_jg_filename_win98($path);
		$path = gui_window->gui_jg($path);
		$path = $::config_obj->os_path($path);
		my $result;
		unless ( $result = kh_cod::func->read_file($self->cfile) ){
			return 0;
		}
		$result->cod_out_csv($self->tani,$path);
	}
	
	$self->close;
}

sub win_label{
	return '�����ǥ��󥰷�̤ν��ϡ�CSV�ե�����';
}

sub win_name{
	return 'w_cod_save_csv';
}
1;