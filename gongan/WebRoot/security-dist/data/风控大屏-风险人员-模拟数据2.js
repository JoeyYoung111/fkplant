//近15天走势
var add_trend=[
  {"text":1,"wen":5,"kong":3,"hei":1,"du":2},
  {"text":2,"wen":1,"kong":2,"hei":3,"du":1},
  {"text":3,"wen":3,"kong":1,"hei":0,"du":2},
  {"text":4,"wen":6,"kong":2,"hei":1,"du":0},
  {"text":5,"wen":4,"kong":0,"hei":1,"du":1},
  {"text":6,"wen":2,"kong":0,"hei":0,"du":0},
  {"text":7,"wen":8,"kong":4,"hei":1,"du":1},
  {"text":8,"wen":2,"kong":5,"hei":1,"du":3},
  {"text":9,"wen":3,"kong":6,"hei":2,"du":1},
  {"text":10,"wen":5,"kong":2,"hei":0,"du":1},
  {"text":11,"wen":6,"kong":2,"hei":2,"du":0},
  {"text":12,"wen":1,"kong":5,"hei":0,"du":1},
  {"text":13,"wen":8,"kong":3,"hei":1,"du":3},
  {"text":14,"wen":3,"kong":1,"hei":0,"du":0},
  {"text":15,"wen":6,"kong":3,"hei":2,"du":1}
];
//涉稳专题-管控级别
var wen_jointcontrollevel=[
  {"text":"一级","value":26},
  {"text":"二级","value":46},
  {"text":"三级","value":300},
  {"text":"自控","value":3387},
  {"text":"存档","value":3333}
];
// //涉稳专题-在控状态
var wen_incontrolllevel=[
  {"text":"在控","value":5117},{"text":"临控","value":10},{"text":"在京","value":0},{"text":"在宁","value":0},{"text":"下落不明","value":0},{"text":"不在控","value":89},{"text":"归档","value":32}];
// //涉稳专题-人员属性
var wen_personneltype=[{"text":"非访","value":643},{"text":"涉军","value":132},{"text":"利益受损","value":1529},{"text":"极端风险","value":386},{"text":"电诈风险","value":50},{"text":"精神障碍","value":1677}];
// //涉恐专题
var kong_nativeplace=[{"text":"和田地区","value":138},{"text":"喀什地区","value":30},{"text":"本地常口","value":16},{"text":"克孜勒苏柯尔克孜","value":8},{"text":"非新疆籍","value":6}].sort(_sortByValue);
var kong_joinntype=[{"text":"红色","value":0},{"text":"橙色","value":1},{"text":"黄色","value":30},{"text":"蓝色","value":183}];
// //涉黑专题
var hei_incontrolllevel=[{"text":"关注中","value":0},{"text":"已打击","value":6063}];
// //涉毒专题
var du_jointcontrollevel=[{"text":"高风险","xi":3,"zhi":42},{"text":"中风险","xi":235,"zhi":15},{"text":"低风险","xi":4585,"zhi":151}];
