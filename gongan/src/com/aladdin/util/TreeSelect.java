package com.aladdin.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TreeSelect {
	/**
	 * @param zlist 
	 * @param titlename 节点名称对应字段
	 * @param pidName	父节点对应字段
	 * @param openBool	节点是否展开
	 * @param rootBool	是否显示根节点
	 * @return
	 */
	public static JSONArray listToTreeSelectJSON(List zlist,String titlename,String istree,String pidName,Boolean openBool,Boolean rootBool){
		List nodes=new ArrayList();
		for (int i = 0; i < zlist.size(); i++) {
			JSONObject node=JSONObject.fromObject(zlist.get(i));
			if(Integer.parseInt(node.get(pidName).toString())==0){
				HashMap<String,Object> tsNode=new HashMap<String, Object>();
				int id= Integer.parseInt(node.get("id").toString());
				tsNode.put("id", id);
				tsNode.put("name",node.get(titlename).toString());
				tsNode.put("title",node.get(titlename).toString());
				tsNode.put("istree",istree==""?"":node.get(istree).toString());
				tsNode.put("open",openBool);
				tsNode.put("checked",false);
				if(childrenNumber(zlist,id,pidName)>0)tsNode.put("children",treeSelectChildren(zlist,titlename,istree,id,pidName,openBool));
				nodes.add(tsNode);
			}
		}
		JSONArray json=new JSONArray();
		if(rootBool){
			HashMap<String,Object> rootNode=new HashMap<String, Object>();
			rootNode.put("id", 0);
			rootNode.put("name","根节点");
			rootNode.put("title","根节点");
			rootNode.put("istree","");
			rootNode.put("open",true);
			rootNode.put("checked",false);
			rootNode.put("children",nodes);
			
			List rootnodes=new ArrayList();
			rootnodes.add(rootNode);
			json=JSONArray.fromObject(rootNode);
		}else{
			json=JSONArray.fromObject(nodes);
		}
		return json;
		
	}
	/**
	 * @param zlist 
	 * @param titlename 节点名称对应字段
	 * @param pidName	父节点对应字段
	 * @param openBool	节点是否展开
	 * @param rootBool	是否显示根节点
	 * @return
	 */
	public static JSONArray listToTreeSelectJSON_New(List zlist,String titlename,String istree,String pidName,Boolean openBool,Boolean rootBool){
		List nodes=new ArrayList();
		for (int i = 0; i < zlist.size(); i++) {
			JSONObject node=JSONObject.fromObject(zlist.get(i));
			int id= Integer.parseInt(node.get("id").toString());
			int pid=Integer.parseInt(node.get(pidName).toString());
			if(parentNumber(zlist, pid)==0){
				HashMap<String,Object> tsNode=new HashMap<String, Object>();
				tsNode.put("id", id);
				tsNode.put("name",node.get(titlename).toString());
				tsNode.put("title",node.get(titlename).toString());
				tsNode.put("istree",istree==""?"":node.get(istree).toString());
				tsNode.put("open",openBool);
				tsNode.put("checked",false);
				if(childrenNumber(zlist,id,pidName)>0)tsNode.put("children",treeSelectChildren(zlist,titlename,istree,id,pidName,openBool));
				nodes.add(tsNode);
			}
		}
		JSONArray json=new JSONArray();
		if(rootBool){
			HashMap<String,Object> rootNode=new HashMap<String, Object>();
			rootNode.put("id", 0);
			rootNode.put("name","根节点");
			rootNode.put("title","根节点");
			rootNode.put("istree","");
			rootNode.put("open",true);
			rootNode.put("checked",false);
			rootNode.put("children",nodes);
			
			List rootnodes=new ArrayList();
			rootnodes.add(rootNode);
			json=JSONArray.fromObject(rootNode);
		}else{
			json=JSONArray.fromObject(nodes);
		}
		return json;
		
	}
	private static int parentNumber(List zlist,int pid){
		int n=0;
		for (int i = 0; i < zlist.size(); i++) {
			JSONObject node=JSONObject.fromObject(zlist.get(i));
			if(Integer.parseInt(node.get("id").toString())==pid)n++;
		}
		return n;
	}
	private static int childrenNumber(List zlist,int pid,String pidName){
		int n=0;
		for (int i = 0; i < zlist.size(); i++) {
			JSONObject node=JSONObject.fromObject(zlist.get(i));
			if(Integer.parseInt(node.get(pidName).toString())==pid)n++;
		}
		return n;
	}
	private static List treeSelectChildren(List zlist,String titlename,String istree,int pid,String pidName,Boolean openBool){
		List nodes=new ArrayList();
		for (int i = 0; i < zlist.size(); i++) {
			JSONObject node=JSONObject.fromObject(zlist.get(i));
			if(Integer.parseInt(node.get(pidName).toString())==pid){
				HashMap<String,Object> tsNode=new HashMap<String, Object>();
				int id= Integer.parseInt(node.get("id").toString());
				tsNode.put("id", id);
				tsNode.put("name",node.get(titlename).toString());
				tsNode.put("title",node.get(titlename).toString());
				tsNode.put("istree",istree==""?"":node.get(istree).toString());
				tsNode.put("open",openBool);
				tsNode.put("checked",false);
				if(childrenNumber(zlist,id,pidName)>0)tsNode.put("children",treeSelectChildren(zlist,titlename,istree,id,pidName,openBool));
				nodes.add(tsNode);
			}
		}
		return nodes;
	}
	public static JSONArray listToTagtreeJSON(List zlist,String titlename,String pidName){
		List nodes=new ArrayList();
		for (int i = 0; i < zlist.size(); i++) {
			JSONObject node=JSONObject.fromObject(zlist.get(i));
			if(Integer.parseInt(node.get(pidName).toString())==0){
				HashMap<String,Object> tsNode=new HashMap<String, Object>();
				int id= Integer.parseInt(node.get("id").toString());
				tsNode.put("value", id);
				tsNode.put("name",node.get(titlename).toString());
				if(childrenNumber(zlist,id,pidName)>0)tsNode.put("children",tagtreeChildren(zlist,titlename,id,pidName));
				else tsNode.put("children",new ArrayList());
				nodes.add(tsNode);
			}
		}
		JSONArray json=new JSONArray();
		json=JSONArray.fromObject(nodes);
		return json;
		
	}
	private static List tagtreeChildren(List zlist,String titlename,int pid,String pidName){
		List nodes=new ArrayList();
		for (int i = 0; i < zlist.size(); i++) {
			JSONObject node=JSONObject.fromObject(zlist.get(i));
			if(Integer.parseInt(node.get(pidName).toString())==pid){
				HashMap<String,Object> tsNode=new HashMap<String, Object>();
				int id= Integer.parseInt(node.get("id").toString());
				tsNode.put("value", id);
				tsNode.put("name",node.get(titlename).toString());
				if(childrenNumber(zlist,id,pidName)>0)tsNode.put("children",tagtreeChildren(zlist,titlename,id,pidName));
				else tsNode.put("children",new ArrayList());
				nodes.add(tsNode);
			}
		}
		return nodes;
	}
}
