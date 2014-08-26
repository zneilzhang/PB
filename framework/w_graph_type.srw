HA$PBExportHeader$w_graph_type.srw
forward
global type w_graph_type from w_response
end type
type uo_1 from u_graph_gallery within w_graph_type
end type
end forward

global type w_graph_type from w_response
integer x = 214
integer y = 221
integer width = 2235
integer height = 1188
uo_1 uo_1
end type
global w_graph_type w_graph_type

type variables
graph igr_parm
object io_passed
end variables

on w_graph_type.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_graph_type.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;// Receive and remember in the igr_parm or idw_parm instance variable, the
// object that has been passed by the window that opened this.

graphicobject lgro_hold

lgro_hold = message.powerobjectparm

If lgro_hold.TypeOf() = Graph! Then
	io_passed = Graph!
	igr_parm = message.powerobjectparm
End If

end event

type uo_1 from u_graph_gallery within w_graph_type
integer width = 2217
integer height = 1100
integer taborder = 30
boolean border = false
end type

on uo_1.destroy
call u_graph_gallery::destroy
end on

event gallery_ok;call super::gallery_ok;int li_col,li_row, li_ret
string ls_graph_type

// Get the graph type from the graph gallery user object.
li_ret = uf_query_gallery (li_row, li_col, ls_graph_type)
if li_ret = 0 then
	messagebox ("Sorry!","Clicked on invalid type")
	return
end if


If io_passed = Graph! Then
	// The user clicked on a graph type. Set the type in the passed graph
	// object.
	Choose Case ls_graph_type
		case "area3d"
			igr_parm.graphtype = area3d!
		case "areagraph"
			igr_parm.graphtype = areagraph!
		case "bar3dobjgraph"
			igr_parm.graphtype = bar3dobjgraph!
		case "barstack3dobjgraph"
			igr_parm.graphtype = barstack3dobjgraph!
		case "bargraph"
			igr_parm.graphtype = bargraph!
		case "bar3dgraph"
			igr_parm.graphtype = bar3dgraph!
		case "barstackgraph"
			igr_parm.graphtype = barstackgraph!
		case "col3dgraph"
			igr_parm.graphtype = col3dgraph!
		case "col3dobjgraph"
			igr_parm.graphtype = col3dobjgraph!
		case "colgraph"
			igr_parm.graphtype = colgraph!
		case "colstack3dobjgraph"
			igr_parm.graphtype = colstack3dobjgraph!
		case "colstackgraph"
			igr_parm.graphtype = colstackgraph!
		case "line3d"
			igr_parm.graphtype = line3d!
		case "linegraph"
			igr_parm.graphtype = linegraph!
		case "pie3d"
			igr_parm.graphtype = pie3d!
		case "piegraph"
			igr_parm.graphtype = piegraph!
		case "scattergraph"
			igr_parm.graphtype = scattergraph!
		case else
			messagebox ("Error!", "Invalid Graph Type")
	end choose

End If
Close (parent)
end event

event gallery_cancel;call super::gallery_cancel;Close (parent)

end event

