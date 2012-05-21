function f = reaction_diffusion_1d_pbc(r,D,N)

%form the diffusion operator
argstr = '';
for i=1:length(D)
    temp{i} = D(i)*spdiags(repmat([1 -2 1],N,1), -1:1, N, N);
    temp{i}(1,N) = D(i);temp{i}(N,1) = D(i);
    argstr = [argstr 'temp{' int2str(i) '},']; 
end
L = eval(['blkdiag(' argstr(1:end-1) ')']);

%may want to/need to refactor to explicit allow for r interlaced and no
%reshape on x after flattening
f = @(t,x) reshape(r(reshape(x,N,length(D))),N*length(D),1) + L*x;

