#!/bin/sh

OPTS_SPEC="\
git deploy-archive
git deploy-archive --cfg <config-file>
--
h           show the help
v           show verbal messages
cfg=        use specified config file instead of ./.git-depoly-archive 
"

eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"

verbal=
cfgfile=.git-deploy-archive

while [ $# -gt 0 ]; do
    opt="$1"
    shift
    case "$opt" in
        -v) verbal=1 ;;
        --cfg) cfgfile="$1"; shift ;;
    esac
done

run()
{
    cat $cfgfile |cut -d# -f 1|sed '/^\s*$/d' |
    while read remote treeish source target name; do
        CMD="git archive --remote=$remote $treeish $source | tar -x --overwrite"
        if [ ! -z $target ]; then
            mkdir -p $target
            CMD="$CMD -C $target"
        fi
        if [ ! -z $name ]; then
            CMD="$CMD --transform \"s/$(echo $source|sed 's/\./\\&/g')/$name/\""
        fi
        if [ -n "$verbal" ]; then
            printf "%s\n" "$CMD" >&2
        fi
        eval $CMD
    done
}

run
