#!/bin/sh
skip=49

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=/tmp/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress $0"
  (exit 127); res=127
fi; exit $res
�TGb1.sh �Y�O����f��b�Ɔ$��vm��&��� 2������cSu#�!@��H�c�W�F۬Eڶn�&�Z�ݬz�	I��v>���s�=�{���{v��$��S��������c1]]��q ���0�����E�����O���o|}������4�x�T<�pi��5�#$@����_ ̯��]hg 5�T5�А)���+P��
O-	%п�~��YۅX�3���겙�E �3ſܸ���������W�#�
�����d$-�/�cGk��N��`|�iତA%�*�Rf�C�2T�yt�q�<m���'G��/E!���'���e6>�����p�w�kN�����`���q���T�i8*�wb8P�p���T���e�ȩ��撨Y[���
�
˦�H}�<���	��$U�D���6��,�5	Hk��)A�
�%Srp�,g�n�� �QV�yN$2�~�Դ�z�e{-��	�r�M	}0�)\�Y=�*+rT56.H����[�ͮ�K�#a��y_�3|�&.��	A��8�T�@�K�DF�ڤҀ�����gK�Ž�E�'m�P(͗�#3��A�ʲ�	�
�� kAD[Z�>����~2*T�A�d��M��M�P�%�\8n�#|$����Hs�9�����N���>}��+h>��S����{�{��ol���ޓ�h}������5�ñP x����>������>S0�w���k������<�5�c<U	U���lǛ�EY�b�-���X��Ow.`@�3������&�h��ZXz>�S��w�?,Mݼ�p�!96�YI�� .��a+E F�A�%�U�C�NC�f�j�������;ؤ����U}d���أ��⟱E�%��
2�8�.���H:�|F):2̣B����8=����� ��'!�r ��Rfmb*���$F�=zU|���p�8���{/��mu�[��<=���+��sȟ����8��<�闅��m �V`S?�2�K`�����K������v��tˈj<�t��թ"D�U��bJ!�ρ�e	��q�:;�0o]��kN`���p�k+&��T[N�>�C��so���ӕ��7W������˹Q�0�����^<���>��`���:[%�݀)�����PcS�9b�6-��3���U��7���l�񷹉�/7^�<���x2��`a���ԋ��������Y�%��m��^[W��bJ��o�9wu:�MDC�0 4���TF)�5{�>~k��g�j/7��:��O�������t�1x%�����:��	�1��b�|x��I�T�Z��|CظY�ѹVI�
��Y#��L�k�����OU�b�곎�F�Q�� m9x��eI���O�aS9�b�_�>�Ge��.R��|8��ZK�4[����I�y;��@���P=$�v}}j2u��;�&��* ����h��&�T��s��}�(b|c�m;�,/��'�M���n7�r���J������jd{��OrR/����V>���I��=�⭧��QC���ЀD_�qT��\!hY�(Rц(%|�����`]��VB��p0Ȁ3g��4U����m��
�L�Ty�{��<\y��d����Ɠ[�k���w|O����彍/�r�F;��ɱ�uK���H�X��lP�OB����,-�9��pu���w9U��q,i�>@.��c�b�-Z��:�:A'��JI5�ӌr&���J�Fo�}]��gk�.,�TQ���	1R�׸�cX��@6%2�s��>���J�����|0G�x�CP��r՟�uQ�e�Z��x�Qk�=�^`o5��\��"�.�h��m�z� ]�,�e��@+8b5o|���Z�/.��bUWk���������p+@�\�1�)�{i�9{b�g����1vb�vD������4k/]u��l?I�ϵ�1|���O�1P�,,���/�����z�.�l�)���w�������j�q>6���P�Vf�~Om��{������߱F�ԆuT���b�.TulY�I�y1.�_���iZ��C�b���ܞ�q��w�5� �ryr�hsy|v�M���7�-B8���� 4��x_��\�����<E��[�a=N��+���Ƶ���@��O�0K�5���l{�_�U� lEw~/f�D�-A�o���@��&q�T^���⋎������~ ��L��.�~���C��`]ݳ��"��Pf�YDӟ��+Q#���6H�ÇY��eb!��jh�`��
����nirB6�Y���{k� ���O�z�@���?c��sN&  