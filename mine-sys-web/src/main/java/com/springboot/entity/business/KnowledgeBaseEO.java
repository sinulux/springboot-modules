package com.springboot.entity.business;

import com.springboot.entity.hibernate.impl.ABaseEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 问答知识库
 * @author wangshibao
 * @version 2018-11-03 11:12
 */
@Entity
@Table(name = "CMS_KNOWLEDGE_BASE")
public class KnowledgeBaseEO extends ABaseEntity {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="KNOWLEDGE_BASE_ID")
    private Long knowledgeBaseId;

    @Column(name="CONTENT_ID")
    private Long contentId;

    //所属分类
    @Column(name="CATEGORY_CODE")
    private String categoryCode;

    //所属分类名称
    @Column(name="CATEGORY_NAME")
    private String categoryName;

    //详细内容
    @Column(name="CONTENT_")
    private String content;

    //答复内容
    @Column(name = "REPLY_CONTENT")
    private String replyContent;

    public Long getKnowledgeBaseId() {
        return knowledgeBaseId;
    }

    public void setKnowledgeBaseId(Long knowledgeBaseId) {
        this.knowledgeBaseId = knowledgeBaseId;
    }

    public Long getContentId() {
        return contentId;
    }

    public void setContentId(Long contentId) {
        this.contentId = contentId;
    }

    public String getCategoryCode() {
        return categoryCode;
    }

    public void setCategoryCode(String categoryCode) {
        this.categoryCode = categoryCode;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }
}
