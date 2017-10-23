FROM centos:7
# TODO: wget spectool rpmbuild yum-builddep make epel-release
RUN yum clean metadata \
    && yum -y update \
    && yum -y install @"Development Tools" rsync rpmdevtools \
    && yum clean all \
    && rm -rf /var/cache/yum

ADD bin /usr/bin
