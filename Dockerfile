# Use Oracle Lunux 7.2 as base image
FROM oraclelinux:7.2

# Copy database distribution to filesystem
COPY assets/database /tmp/orcl12c/

# Preconfigure Linux before installing Oracle Database 12c
RUN yum install -y oracle-rdbms-server-12cR1-preinstall && yum clean all

# Set environment variables
ENV ORACLE_BASE=/u01/app/oracle
ENV ORACLE_HOME=$ORACLE_BASE/product/12.1.0/db_1
ENV ORACLE_SID=orcl
ENV PATH="$ORACLE_HOME/bin:${PATH}"

# Create Oracle base directory and inventory directory
RUN mkdir -p $ORACLE_BASE && chown -R oracle:oinstall $ORACLE_BASE && chmod -R 775 $ORACLE_BASE
RUN mkdir $ORACLE_BASE/../oraInventory && chown -R oracle:oinstall $ORACLE_BASE/../oraInventory && chmod -R 775 $ORACLE_BASE/../oraInventory

# Copy response files for Oracle Universal Installer
COPY assets/rsp /home/oracle/rsp/
RUN chown -R oracle:oinstall /home/oracle/rsp && chmod 600 /home/oracle/rsp/*.rsp

# Run Oracle Universal Installer to install database
USER oracle
RUN /tmp/orcl12c/runInstaller -ignoreSysPrereqs -ignorePrereq -silent -noconfig -waitforcompletion -responseFile /home/oracle/rsp/db_install.rsp

# Run root scripts
USER root
RUN $ORACLE_BASE/../oraInventory/orainstRoot.sh && $ORACLE_HOME/root.sh

# Run Net Configuration Assistant
USER oracle
RUN netca -silent -responsefile /home/oracle/rsp/netca.rsp

# Run Database Configuration Assistant
RUN dbca -silent -responseFile /home/oracle/rsp/dbca.rsp || true;

# Expose ports
EXPOSE 1521 5500

# Cleanup
USER root
RUN rm -rf /tmp/orcl12c && rm -rf /home/oracle/rsp

USER oracle
