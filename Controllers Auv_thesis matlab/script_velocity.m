clc;
clear;
i_velocity_linear = [];
j_velocity_linear = [];
stages=input("how many steps stages has the velocity:  ");
for stage=1:stages
    stri= "introduce the "+ stage+ " stage for the linear velocity in ";
    strj= "introduce the "+ stage+ " stage for the linear velocity in ";
    strk= "introduce the "+ stage+ " stage for the linear velocity in ";
    valuei=input(stri + " i: ");
    valuej=input(stri + " j: ");
%   valuek=input(stri+k);
    i_velocity_linear = [i_velocity_linear, valuei];
    j_velocity_linear = [j_velocity_linear, valuej];
%   k_velocity_linear = [k_velocity_linear, valuek];
end

k_velocity_linear= zeros(1,length(i_velocity_linear));
i_velocity_angular=[];
j_velocity_angular=[];
k_velocity_angular= [];
n=length(i_velocity_linear);
inertialx=[1/100 -2/100 1];
inertialy=[1 0 -0.01];
inertialz=[0 1 0.2];
inertial=[inertialx.' inertialy.' inertialz.'];
propeller_radius=60/2;
mass=3.95572;
for k=1:n
    i_velocity_angular=[i_velocity_angular,i_velocity_linear(k)/propeller_radius];
    j_velocity_angular=[j_velocity_angular,j_velocity_linear(k)/propeller_radius];
    k_velocity_angular=[k_velocity_angular,k_velocity_linear(k)/propeller_radius];
end
w=[diff(i_velocity_angular.') diff(j_velocity_angular.') diff(k_velocity_angular.')];
v0c=[diff(i_velocity_linear.') diff(j_velocity_linear.') diff(k_velocity_linear.')];
v=[(i_velocity_linear.') (j_velocity_linear.') (k_velocity_linear.')];
length_time=length(i_velocity_linear)-1;
length_difftime=length(i_velocity_angular)-1;
time=[0:1:length_time];
difftime=[0:1:length_difftime];

subplot(3,3,1)
plot(time, i_velocity_linear)
ylabel(['i velocity'])
xlabel(['time'])

subplot(3,3,2)
plot(time,j_velocity_linear)
ylabel(['j velocity'])
xlabel(['time'])

subplot(3,3,3)
plot(time,k_velocity_linear)
ylabel(['k velocity'])
xlabel(['time'])

subplot(3,3,4)
plot(time, i_velocity_angular)
ylabel(['i velocity angular'])
xlabel(['time'])

subplot(3,3,5)
plot(time,j_velocity_angular)
ylabel(['j velocity angular'])
xlabel(['time'])

subplot(3,3,6)
plot(time,k_velocity_angular)
ylabel(['k velocity'])
xlabel(['time'])

vinicial=v(1:end-1,1:3);
fc=mass*(v0c+(cross(w,vinicial)));%problema con las dimensiones del vector aceleracion preguntar como hacer ese reshape

figure(1)
subplot(3,3,7)
plot(difftime(1:end-1),fc(1:end,1))
ylabel(['Force at i in gravity center'])
xlabel(['time'])

subplot(3,3,8)
plot(difftime(1:end-1),fc(1:end,2))
ylabel(['Force at j in gravity center'])
xlabel(['time'])

subplot(3,3,9)
plot(difftime(1:end-1),fc(1:end,3))
ylabel(['Force at k in gravity center'])
xlabel(['time'])

%aqui preguntar por tamaño inertial y preguntar por la perdida de valores
%en la derivacion de las variables
a=(inertial*w.');
w_diferential=diff(w);
b=inertial*w_diferential.';
c= cross(w,a.');
mc=b.'+ c(1:end-1,1:3);
figure(2);
subplot(1,3,1)
plot(difftime(1:end-2),mc(:,1))
ylabel(['rotational equation at i'])
xlabel(['time'])
subplot(1,3,2)
plot(difftime(1:end-2),mc(:,2))
ylabel(['rotational equation at j'])
xlabel(['time'])
subplot(1,3,3)
plot(difftime(1:end-2),mc(:,3))
ylabel(['rotational equation at k'])
xlabel(['time'])

