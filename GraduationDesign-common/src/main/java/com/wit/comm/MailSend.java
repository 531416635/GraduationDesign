package com.wit.comm;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
*
* 操作邮件的工具类，该工具类初始化需提供了发送者邮箱地址等信息 发送支持多个收件人，
* 附件 html 及文本
*
*
*/
public class MailSend {

    // 定义发件人别名
    private String displayName;

    // 邮件发送者
    private String from;

    // 邮件服务器
    private String smtpServer;

    // 用户名
    private String username;

    // 密码
    private String password;

    // 字符集
    private String charset = "UTF-8";

    /**
     * 初始化SMTP服务器地址
     *
     * @param smtpServer
     *            服务器地址
     * @param from
     *            发送者
     * @param displayName
     *            别名
     * @param username
     *            用户名
     * @param password
     *            密码
     */
    public MailSend(String smtpServer, String from,
            String displayName, String username, String password) {
        this.smtpServer = smtpServer;
        this.from = from;
        this.displayName = displayName;
        this.username = username;
        this.password = password;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getSmtpServer() {
        return smtpServer;
    }

    public void setSmtpServer(String smtpServer) {
        this.smtpServer = smtpServer;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCharset() {
        return charset;
    }

    public void setCharset(String charset) {
        this.charset = charset;
    }

    /**
     * @param to
     *            发送地址
     * @param isAuth
     *            是否需要认证
     * @param subject
     *            主题
     * @param content
     *            内容
     * @param isHtml
     *            是否是html
     * @param files
     *            附件
     * @return
     * @throws MessagingException
     * @throws UnsupportedEncodingException
     */
    public void send(String[] tos, boolean isAuth, String subject,
            String content, boolean isHtml) {
        Session session = null;
        Properties props = System.getProperties();
        props.put("mail.smtp.host", smtpServer);
        if (isAuth) { // 服务器需要身份认证
            props.put("mail.smtp.auth", "true");
            // 生成认证的Authenticator
            Authenticator authenticator = new Authenticator() {
                @Override
				protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication(username,
                            password);
                }
            };
            session = Session.getDefaultInstance(props, authenticator);
        } else {
            props.put("mail.smtp.auth", "false");
            session = Session.getDefaultInstance(props, null);
        }
        // 是否debug
        session.setDebug(true);
        Transport trans = null;
        try {
            trans = session.getTransport("smtp");
        } catch (NoSuchProviderException e) {
            e.printStackTrace();
        }

        // 多个接收人
        InternetAddress[] address = new InternetAddress[tos.length];
        for (int i = 0; i < address.length; i++) {
            try {
                address[i] = new InternetAddress(tos[i]);
            } catch (AddressException e) {
                e.printStackTrace();
            }
        }

        // 连接服务器
        try {
            trans.connect("27.17.37.34", "zcsl", "zcsl123");
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // 生成发送的消息
        Message msg = new MimeMessage(session);

        // 邮件的地址及别名
        Address from_address = null;
        try {
            from_address = new InternetAddress(from, "zcsl@china-cpp.com");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 设置
        try {
            msg.setFrom(from_address);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // 设置接收人地址
        try {
            msg.setRecipients(Message.RecipientType.TO, address);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // 设置发送主题
        try {
            msg.setSubject(subject);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // 部件
        Multipart mp = new MimeMultipart();

        // body部件
        MimeBodyPart mbp = new MimeBodyPart();

        // 判断发送的是否是html格式
        if (isHtml) {// 如果是html格式
            try {
                mbp.setContent(content, "text/html;charset=" + charset);
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        } else {
            try {
                mbp.setText(content);
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        }
        // 将该正文部件加入到整体部件
        try {
            mp.addBodyPart(mbp);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // Multipart加入到信件
        try {
            msg.setContent(mp);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // 设置信件头的发送日期
        try {
            msg.setSentDate(new Date());
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // 发送信件
        try {
            msg.saveChanges();
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        // 发送
        try {
            trans.sendMessage(msg, msg.getAllRecipients());
        } catch (MessagingException e1) {
            e1.printStackTrace();
        }

        // 结束
        try {
            trans.close();
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) throws UnsupportedEncodingException,
            MessagingException {

        MailSend mailUtil = new MailSend(
                "27.17.37.34", "zcsl@china-cpp.com", "公彩网络科技有限公司",
                "zcsl", "zcsl123");// 设置发件人相关

        String SendTitle = "标题";// 邮件标题

        String SendContent = Integer.toString((int)(Math.random()*1000000));// 邮件内容

        String receiveAddress[] = { "tangxiao8899@126.com",
                "287957528@qq.com" };

        mailUtil.send(receiveAddress, false, SendTitle, SendContent, false);
    }
	
}
