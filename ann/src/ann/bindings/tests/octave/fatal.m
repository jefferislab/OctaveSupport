ann

pts=[-0.297462,0.176102;
0.565538,-0.361496;
];

kd=ANNkd_tree(pts)

try
  [nn_idx,dd]=kd.annkSearch([0.0902484,-0.207129],10)
  error
catch
end_try_catch
