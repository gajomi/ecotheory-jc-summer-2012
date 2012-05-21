
%Set up diffusion for three species
N = 100;
D = [1 50];
r = @(gamma,a,b,z) gamma*[a-z(:,1)+z(:,2).*z(:,1).^2 b-z(:,2).*z(:,1).^2];
gamma = 1;
a = .2;
b = 1.5;

%make rd systems with particular set of parameters
f = reaction_diffusion_1d_pbc(@(z) r(gamma,a,b,z),D,N);

%integrate reaction diffusion from certain initial condition
T = 20;
x0 = zeros(N,2); 
x0(:,1) = a+b+.01*rand(N,1);
x0(:,2) = b/(a+b)^2+.01*rand(N,1);
[t,x] = ode45(f,[0 T], x0);
x = reshape(x,length(t),N,length(D));

%shwo some plots
figure(1)
subplot(2,1,1)
imagesc(t,1:N,x(:,:,1))
xlabel('cell')
ylabel('time')
subplot(2,1,2)
imagesc(t,1:N,x(:,:,2))
xlabel('cell')
ylabel('time')



